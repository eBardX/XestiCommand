// © 2018 J. G. Pusey (see LICENSE.md)

open class Tool {

    // MARK: Open Instance Methods

    open func run() throws {
        qfatalError("Subclass must override")
    }

    // MARK: Public Initializers

    public init(registry: CommandRegistry,
                command: Command,
                parameters: [String: String]) {
        self.command = command
        self.parameters = parameters
        self.registry = registry
    }

    // MARK: Public Instance Properties

    public let command: Command
    public let parameters: [String: String]
    public unowned let registry: CommandRegistry
}
