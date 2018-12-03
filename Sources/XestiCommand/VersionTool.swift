// © 2018 J. G. Pusey (see LICENSE.md)

public class VersionTool: Tool {

    // MARK: Overridden Tool Methods

    override public func run() throws {
        #if os(macOS)
        let platform = " (macOS)"
        #else
        let platform = ""
        #endif

        qprint("\(registry.fancyName) \(registry.version)\(platform)")
    }
}
