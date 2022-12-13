// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "LADVSwift",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_12),
        .tvOS(.v11),
        .watchOS(.v2)
    ],
    products: [
        .library(
            name: "LADVSwift",
            targets: ["LADVSwift"])
    ],
    dependencies: [
        .package(url: "https://github.com/dbsystel/DBNetworkStack", from: "3.0.0"),
        .package(url: "https://github.com/cezheng/Fuzi", from: "3.1.3")
    ],
    targets: [
        .target(
            name: "LADVSwift",
            dependencies: ["DBNetworkStack", "Fuzi"],
            path: "LADVSwift"),
        .testTarget(
            name: "LADVSwiftTests",
            dependencies: ["LADVSwift"],
            path: "LADVSwiftTests",
            resources: [
                .process("LADVMEldeListe.html")
            ]
        )
    ]
)
