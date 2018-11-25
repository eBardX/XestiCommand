//
//  ZipAction.swift
//  XestiCommand
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

import Foundation
import XestiPath

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
