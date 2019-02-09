// © 2019 J. G. Pusey (see LICENSE.md)

public struct Argument {

    // MARK: Public Initializers

    public init(name: String,
                summary: String,
                isRequired: Bool = false) {
        self.isRequired = isRequired
        self.name = name
        self.summary = summary
    }

    // MARK: Public Instance Properties

    public let isRequired: Bool
    public let name: String
    public let summary: String
}
