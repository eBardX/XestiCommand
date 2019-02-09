// © 2018 J. G. Pusey (see LICENSE.md)

public struct Command {

    // MARK: Public Initializers

    public init(name: String,
                summary: String,
                options: [Option] = [],
                arguments: [Argument] = [],
                makeTool: @escaping (Registry, Command, [String: String]) -> Tool) {
        self.arguments = arguments
        self.makeTool = makeTool
        self.name = name
        self.options = options.sorted { $0.name < $1.name }
        self.summary = summary
    }

    // MARK: Public Instance Properties

    public let arguments: [Argument]
    public let makeTool: (Registry, Command, [String: String]) -> Tool
    public let name: String
    public let options: [Option]
    public let summary: String
}
