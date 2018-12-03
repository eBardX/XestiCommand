// © 2018 J. G. Pusey (see LICENSE.md)

import XestiText

public protocol ExtendedError: Error, CustomStringConvertible {
    var hints: [String] { get }
    var hintsPrefix: String { get }
    var message: String { get }
    var messagePrefix: String { get }
}

public extension ExtendedError {

    // MARK: Public Instance Properties

    var description: String {
        let totalWidth = Format.terminalWidth()

        var text = Format.hangIndent(prefix: messagePrefix,
                                     text: message,
                                     totalWidth: totalWidth)

        for hint in hints {
            text += "\n"
            text += Format.hangIndent(prefix: hintsPrefix,
                                      text: hint,
                                      totalWidth: totalWidth)
        }

        return text
    }

    var hints: [String] {
        return []
    }

    var hintsPrefix: String {
        return "👉  "
    }

    var messagePrefix: String {
        return "💥  "
    }
}
