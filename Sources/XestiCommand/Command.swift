// © 2018 J. G. Pusey (see LICENSE.md)

public struct Command {

    // MARK: Public Initializers

    public init(name: String,
                summary: String,
                options: [String: (summary: String, value: Bool)] = [:],
                arguments: [(name: String, summary: String, required: Bool)] = [],
                makeTool: @escaping (CommandRegistry, Command, [String: String]) -> Tool) {
        self.arguments = arguments
        self.makeTool = makeTool
        self.name = name
        self.options = options
        self.summary = summary
    }

    // MARK: Public Instance Properties

    public let arguments: [(name: String, summary: String, required: Bool)]
    public let makeTool: (CommandRegistry, Command, [String: String]) -> Tool
    public let name: String
    public let options: [String: (summary: String, value: Bool)]
    public let summary: String
}
