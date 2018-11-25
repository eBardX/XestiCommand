//
//  SubprocessAction.swift
//  XestiCommand
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

import Foundation
import XestiPath

open class SubprocessAction {

    // MARK: Public Initializers

    public init(executablePath: Path,
                arguments: [String] = [],
                currentDirectoryPath: Path? = nil,
                environment: [String: String]? = nil) {
        self.process = Process()

        self.process.arguments = arguments

        if let cdPath = currentDirectoryPath {
            if #available(OSX 10.13, *) {
                process.currentDirectoryURL = cdPath.absolute.fileURL
            } else {
                process.currentDirectoryPath = cdPath.absolute.rawValue
            }
        }

        if let env = environment {
            self.process.environment = env
        }

        if #available(OSX 10.13, *) {
            self.process.executableURL = executablePath.absolute.fileURL
        } else {
            self.process.launchPath = executablePath.absolute.rawValue
        }
    }

    // MARK: Public Instance Methods

    @discardableResult
    open func run() throws -> (status: Int, output: Data, error: Data) {
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        let inputPipe = Pipe()

        process.standardError = errorPipe
        process.standardInput = inputPipe
        process.standardOutput = outputPipe

        process.launch()
        process.waitUntilExit()

        let output = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let error = errorPipe.fileHandleForReading.readDataToEndOfFile()
        let status = Int(process.terminationStatus)

        return (status: status,
                output: output,
                error: error)
    }

    // MARK: Private Instance Properties

    private let process: Process
}
