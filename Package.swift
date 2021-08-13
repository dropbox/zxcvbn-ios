// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Zxcvbn",
    products: [
        .library(name: "Zxcvbn", targets: ["Zxcvbn"])
    ],
    targets: [
        .target(
            name: "Zxcvbn",
            path: "Zxcvbn",
            exclude: [
                "Info.plist",
                "Zxcvbn.h"
            ],
            resources: [
                .copy("generated/adjacency_graphs.json"),
                .copy("generated/frequency_lists.json"),
            ],
            publicHeadersPath: "include"
        ),
        .testTarget(
            name: "ZxcvbnTests",
            dependencies: ["Zxcvbn"],
            path: "ZxcvbnTests",
            exclude: [
                "Info.plist"
            ]
        )
    ]
)
