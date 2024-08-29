// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIGenericListView",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SwiftUIGenericListView",
            targets: ["SwiftUIGenericListView"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUIGenericListView",
            dependencies: [],
            path: "Sources/SwiftUIGenericListView"
        ),
        .testTarget(
            name: "SwiftUIGenericListViewTests",
            dependencies: ["SwiftUIGenericListView"],
            path: "Tests"
        ),
    ]
)
