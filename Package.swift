// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Zxcvbn",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "Zxcvbn",
            targets: ["Zxcvbn"])
    ],
    targets: [
        .target(name: "Zxcvbn",
                resources: [
                    .process("Resources")
                ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
