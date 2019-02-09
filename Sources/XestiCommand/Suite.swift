// © 2018 J. G. Pusey (see LICENSE.md)

import Dispatch

open class Suite {

    // MARK: Open Type Methods

    open class func configureRegistry() throws -> Registry {
        qfatalError("Subclass must override")
    }

    // MARK: Public Type Methods

    public static func run(with arguments: [String] = CommandLine.arguments) {
        DispatchQueue.global().async {
            do {
                let registry = try configureRegistry()

                if let tool = try registry.findTool(with: arguments) {
                    try tool.run()
                } else {
                    registry.displayUsage()
                }

                exit(EXIT_SUCCESS)
            } catch {
                qprintError(error)

                exit(EXIT_FAILURE)
            }
        }

        dispatchMain()
    }
}
