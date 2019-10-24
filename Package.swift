// swift-tools-version:5.1

// © 2018 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiCommand",
                      products: [.library(name: "XestiCommand",
                                          targets: ["XestiCommand"])],
                      dependencies: [.package(url: "https://github.com/eBardX/XestiPath.git",
                                              from: "1.0.2"),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              from: "1.1.2")],
                      targets: [.target(name: "XestiCommand",
                                        dependencies: ["XestiPath", "XestiText"])])
