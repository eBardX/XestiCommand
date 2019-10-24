// © 2018 J. G. Pusey (see LICENSE.md)

import XestiPath

#if os(macOS)
public class UnzipAction: SubprocessAction {

    // MARK: Public Initializers

    public init(zipPath: Path,
                destinationPath: Path,
                currentDirectoryPath: Path? = nil) {
        super.init(executablePath: Path("/usr/bin/unzip"),
                   arguments: ["-q",
                               zipPath.rawValue,
                               "-d",
                               destinationPath.rawValue],
                   currentDirectoryPath: currentDirectoryPath)
    }
}
#endif
