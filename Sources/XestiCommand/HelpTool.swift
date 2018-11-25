//
//  HelpTool.swift
//  XestiCommand
//
//  Created by J. G. Pusey on 2018-11-24.
//
//  © 2018 J. G. Pusey (see LICENSE.md)
//

public class HelpTool: Tool {

    // MARK: Overridden Tool Methods

    override public func run() throws {
        if let commandName = parameters["command"],
            let command = registry.command(named: commandName) {
            registry.displayUsage(for: command)
        } else {
            registry.displayUsage()
        }
    }
}
