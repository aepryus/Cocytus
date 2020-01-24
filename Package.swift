// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cocytus",
    products: [
        .executable(name: "Cocytus", targets: ["Cocytus"])
    ],
    dependencies: [
		.package(url: "https://github.com/wickwirew/Runtime.git", from: "2.0.0")
    ],
    targets: [
        .target(name: "Cocytus", dependencies: ["Runtime"], path: "Sources"),
    ]
)
