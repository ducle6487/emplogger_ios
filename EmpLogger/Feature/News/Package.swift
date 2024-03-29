// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "News",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "News",
            targets: ["News"]
        )
    ],
    dependencies: [
        .package(path: "../Combustion"),
        .package(path: "../CombustionUI"),
        .package(path: "../EmpLoggerCore"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "News",
            dependencies: [
                "Combustion",
                "CombustionUI",
                "EmpLoggerCore",
            ]
        ),
        .testTarget(
            name: "NewsTests",
            dependencies: ["News"]
        ),
    ]
)
