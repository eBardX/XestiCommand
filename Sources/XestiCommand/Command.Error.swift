// © 2018 J. G. Pusey (see LICENSE.md)

public extension Command {
    enum Error {
        case duplicateOption(String, String, String)
        case missingOptionValue(String, String, String)
        case missingArgument(String, String, String)
        case unknownArgument(String, String, String)
        case unknownCommand(String, String)
        case unknownOption(String, String, String)
    }
}

// MARK: - ExtendedError

extension Command.Error: ExtendedError {
    public var hints: [String] {
        switch self {
        case let .duplicateOption(name, command, _),
             let .missingOptionValue(name, command, _),
             let .missingArgument(name, command, _):
            return ["Type ‘\(name) help \(command)’ for details"]

        case let .unknownArgument(name, command, _):
            return ["Type ‘\(name) help \(command)’ for available arguments"]

        case let .unknownCommand(name, _):
            return ["Type ‘\(name) help’ for available commands"]

        case let .unknownOption(name, command, _):
            return ["Type ‘\(name) help \(command)’ for available options"]
        }
    }

    public var message: String {
        switch self {
        case let .duplicateOption(_, _, option):
            return "Duplicate option: ‘\(option)’"

        case let .missingOptionValue(_, _, option):
            return "Missing required value for option: ‘\(option)’"

        case let .missingArgument(_, _, argument):
            return "Missing required argument: ‘\(argument)’"

        case let .unknownArgument(_, _, argument):
            return "Unknown argument: ‘\(argument)’"

        case let .unknownCommand(_, command):
            return "Unknown command: ‘\(command)’"

        case let .unknownOption(_, _, option):
            return "Unknown option: ‘\(option)’"
        }
    }
}
