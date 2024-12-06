// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "LADVSwift",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "LADVSwift",
            targets: ["LADVSwift"])
    ],
    dependencies: [
        .package(url: "https://github.com/dbsystel/DBNetworkStack", from: "3.0.0"),
        .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.5.3")
    ],
    targets: [
        .target(
            name: "LADVSwift",
            dependencies: ["DBNetworkStack", "SwiftSoup"],
            path: "LADVSwift"),
        .testTarget(
            name: "LADVSwiftTests",
            dependencies: ["LADVSwift"],
            path: "LADVSwiftTests",
            resources: [
                .process("meldungStaffel.html"),
                .process("meldung5.html"),
                .process("meldung6.html"),
                .process("meldung7.html"),
                .process("meldung8.html")
            ]
        )
    ]
)
