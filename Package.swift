// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cocytus",
	platforms: [.macOS(.v10_13)],
    products: [
        .library(name: "Cocytus", targets: ["Cocytus"]),
    ],
    dependencies: [
		.package(name: "PerfectHTTPServer", url: "https://github.com/PerfectlySoft/Perfect-HTTPServer", from: "3.0.0"),
		.package(name: "PerfectMySQL", url: "https://github.com/PerfectlySoft/Perfect-MySQL", from: "3.0.0"),
		.package(url: "https://github.com/PerfectSideRepos/PerfectBCrypt.git", from: "3.0.0"),
		.package(url: "https://github.com/wickwirew/Runtime.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "Cocytus", dependencies: ["PerfectHTTPServer", "PerfectMySQL", "PerfectBCrypt", "Runtime"], path: "Sources")
    ]
)
