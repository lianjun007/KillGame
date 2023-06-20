// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodeForum",
    dependencies: [
        .package(url: "https://github.com/johnsundell/ink.git", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            name: "CodeForum",
            path: "Sources"),
    ]
)
