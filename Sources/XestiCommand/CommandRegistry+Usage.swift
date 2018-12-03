// © 2018 J. G. Pusey (see LICENSE.md)

import XestiText

private let defaultHangPadLeft = 2
private let defaultHangPadRight = 1
private let defaultHangWidth = 23

public extension CommandRegistry {

    // MARK: Public Instance Methods

    func displayUsage() {
        let totalWidth = Format.terminalWidth()

        var prefix = ""
        var usage = ""

        // --- OVERVIEW section ---

        prefix = "OVERVIEW:"

        usage += Format.hangIndent(prefix: prefix,
                                   text: summary,
                                   hangPadLeft: 0,
                                   hangWidth: min(prefix.displayWidth,
                                                  defaultHangPadLeft + defaultHangWidth),
                                   hangPadRight: defaultHangPadRight,
                                   totalWidth: totalWidth)

        // --- USAGE section ---

        usage += "\n\n"

        prefix = "USAGE:"

        usage += Format.hangIndent(prefix: prefix,
                                   text: name + " command",
                                   hangPadLeft: 0,
                                   hangWidth: min(prefix.displayWidth,
                                                  defaultHangPadLeft + defaultHangWidth),
                                   hangPadRight: defaultHangPadRight,
                                   totalWidth: totalWidth)

        // --- COMMANDS section ---

        usage += "\n\nCOMMANDS:\n"

        for command in allCommands {
            usage += "\n"
            usage += Format.hangIndent(prefix: command.name,
                                       text: command.summary,
                                       hangPadLeft: defaultHangPadLeft,
                                       hangWidth: defaultHangWidth,
                                       hangPadRight: defaultHangPadRight,
                                       totalWidth: totalWidth)
        }

        qprint(usage)
    }

    func displayUsage(for command: Command) {
        let totalWidth = Format.terminalWidth()

        var prefix = ""
        var usage = ""

        // --- OVERVIEW section ---

        prefix = "OVERVIEW:"

        usage += Format.hangIndent(prefix: prefix,
                                   text: command.summary,
                                   hangPadLeft: 0,
                                   hangWidth: min(prefix.displayWidth,
                                                  defaultHangPadLeft + defaultHangWidth),
                                   hangPadRight: defaultHangPadRight,
                                   totalWidth: totalWidth)

        // --- USAGE section ---

        usage += "\n\n"

        prefix = "USAGE:"

        var tmpSummary = name + " " + command.name

        for argument in command.arguments {
            if !argument.required {
                tmpSummary += " [<\(argument.name)>]"
            } else {
                tmpSummary += " <\(argument.name)>"
            }
        }

        usage += Format.hangIndent(prefix: prefix,
                                   text: tmpSummary,
                                   hangPadLeft: 0,
                                   hangWidth: min(prefix.displayWidth,
                                                  defaultHangPadLeft + defaultHangWidth),
                                   hangPadRight: defaultHangPadRight,
                                   totalWidth: totalWidth)

        // --- OPTIONS section ---

        if !command.options.isEmpty {
            usage += "\n\nOPTIONS:\n"

            let optionKeys = command.options.keys.sorted()

            for optionKey in optionKeys {
                usage += "\n"
                usage += Format.hangIndent(prefix: optionKey,
                                           text: command.options[optionKey]?.summary ?? "",
                                           hangPadLeft: defaultHangPadLeft,
                                           hangWidth: defaultHangWidth,
                                           hangPadRight: defaultHangPadRight,
                                           totalWidth: totalWidth)
            }
        }

        // --- POSITIONAL ARGUMENTS section ---

        if !command.arguments.isEmpty {
            usage += "\n\nPOSITIONAL ARGUMENTS:\n"

            for argument in command.arguments {
                usage += "\n"
                usage += Format.hangIndent(prefix: argument.name,
                                           text: argument.summary,
                                           hangPadLeft: defaultHangPadLeft,
                                           hangWidth: defaultHangWidth,
                                           hangPadRight: defaultHangPadRight,
                                           totalWidth: totalWidth)
            }
        }

        qprint(usage)
    }
}
