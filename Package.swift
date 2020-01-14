// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cocytus",
    products: [
        .library(name: "Cocytus", targets: ["Cocytus"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Cocytus", dependencies: [], path: "Sources")
    ]
)
