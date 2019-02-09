// © 2019 J. G. Pusey (see LICENSE.md)

public struct Option {

    // MARK: Public Initializers

    public init(name: String,
                summary: String,
                hasValue: Bool = false) {
        self.hasValue = hasValue
        self.name = name
        self.summary = summary
    }

    // MARK: Public Instance Properties

    public let hasValue: Bool
    public let name: String
    public let summary: String
}
