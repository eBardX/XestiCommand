// © 2018 J. G. Pusey (see LICENSE.md)

import XestiPath

#if os(macOS)
public class ZipAction: SubprocessAction {

    // MARK: Public Initializers

    public init(sourcePath: Path,
                zipPath: Path,
                currentDirectoryPath: Path? = nil) {
        super.init(executablePath: Path("/usr/bin/zip"),
                   arguments: ["-qry",
                               zipPath.rawValue,
                               sourcePath.rawValue],
                   currentDirectoryPath: currentDirectoryPath)
    }
}
#endif
