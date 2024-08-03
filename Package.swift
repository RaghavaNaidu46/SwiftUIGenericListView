// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIGenericListView",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftUIGenericListView",
            targets: ["SwiftUIGenericListView"]),
    ],
    dependencies: [
        // Add any dependencies here if needed.
    ],
    targets: [
        .target(
            name: "SwiftUIGenericListView",
            dependencies: [],
            path: "Sources/SwiftUIGenericListView",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "SwiftUIGenericListViewTests",
            dependencies: ["SwiftUIGenericListView"],
            path: "Tests/SwiftUIGenericListViewTests"
        ),
    ]
)
