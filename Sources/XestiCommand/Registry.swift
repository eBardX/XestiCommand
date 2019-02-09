// © 2018 J. G. Pusey (see LICENSE.md)

private let defaultVersion = "1.0.0"

public class Registry {

    // MARK: Public Initializers

    public init(name: String,
                summary: String,
                fancyName: String? = nil,
                version: String? = nil) {
        self.commands = [:]
        self.fancyName = fancyName ?? name.capitalized
        self.name = name
        self.summary = summary
        self.version = version ?? defaultVersion
    }

    // MARK: Public Instance Properties

    public let fancyName: String
    public let name: String
    public let summary: String
    public let version: String

    public var allCommands: [Command] {
        return commands.values.sorted { $0.name < $1.name }
    }

    // MARK: Public Instance Methods

    public func command(named name: String) -> Command? {
        return commands[name]
    }

    public func findTool(with arguments: [String]) throws -> Tool? {
        var iterator = arguments.makeIterator()

        //
        // First argument is executable name (which we can skip over):
        //
        guard
            iterator.next() != nil
            else { qfatalError("Bogus command-line arguments!") }

        guard
            let command = try findCommand(&iterator)
            else { return nil }

        let parameters = try parseCommand(command,
                                          &iterator)

        return command.makeTool(self,
                                command,
                                parameters)
    }

    public func register(_ command: Command) {
        commands[command.name] = command
    }

    // MARK: Private Instance Properties

    private var commands: [String: Command]
    private var defaultCommand: Command?

    // MARK: Private Instance Methods

    private func checkForMissingParameters(_ command: Command,
                                           _ parameters: [String: String]) throws {
        for argument in command.arguments
            where argument.isRequired {
                guard
                    parameters[argument.name] != nil
                    else { throw Command.Error.missingArgument(name, command.name, argument.name) }
        }
    }

    private func findCommand(_ iterator: inout IndexingIterator<[String]>) throws -> Command? {
        if let cname = iterator.next() {
            guard
                let command = commands[cname]
                else { throw Command.Error.unknownCommand(name, cname) }

            return command
        }

        return nil
    }

    private func parseCommand(_ command: Command,
                              _ iterator: inout IndexingIterator<[String]>) throws -> [String: String] {
        var parameters: [String: String] = [:]
        var posArgCount: Int = 0

        while let argument = iterator.next() {
            if argument.hasPrefix("-") {
                guard
                    let option = command.options.first(where: { $0.name == argument })
                    else { throw Command.Error.unknownOption(name, command.name, argument) }

                guard
                    parameters[argument] == nil
                    else { throw Command.Error.duplicateOption(name, command.name, argument) }

                if option.hasValue {
                    guard
                        let value = iterator.next(),
                        !value.hasPrefix("-")
                        else { throw Command.Error.missingOptionValue(name, command.name, argument) }

                    parameters[argument] = value
                } else {
                    parameters[argument] = ""
                }
            } else {
                guard
                    posArgCount < command.arguments.count
                    else { throw Command.Error.unknownArgument(name, command.name, argument) }

                let aname = command.arguments[posArgCount].name

                parameters[aname] = argument

                posArgCount += 1
            }
        }

        try checkForMissingParameters(command, parameters)

        return parameters
    }
}
