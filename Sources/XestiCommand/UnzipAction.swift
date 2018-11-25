//
//  UnzipAction.swift
//  XestiCommand
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

import Foundation
import XestiPath

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
