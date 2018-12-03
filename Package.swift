// swift-tools-version:4.2

// © 2018 J. G. Pusey (see LICENSE.md)

import PackageDescription

let package = Package(name: "XestiCommand",
                      products: [.library(name: "XestiCommand",
                                          targets: ["XestiCommand"])],
                      dependencies: [.package(url: "https://github.com/eBardX/XestiPath.git",
                                              from: "1.0.0"),
                                     .package(url: "https://github.com/eBardX/XestiText.git",
                                              from: "1.0.0")],
                      targets: [.target(name: "XestiCommand",
                                        dependencies: ["XestiPath", "XestiText"])])
