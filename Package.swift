// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreAPI",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CoreAPI",
            targets: ["CoreAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/obadasemary/NetworkLayer.git", .upToNextMajor(from: "1.0.4"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CoreAPI",
            dependencies: ["NetworkLayer"]
        ),
        .testTarget(
            name: "CoreAPITests",
            dependencies: ["CoreAPI"]
        ),
    ]
)
