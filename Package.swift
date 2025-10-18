// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CSVDataViewer",
    platforms: [
        .macOS(.v14) // macOS Sonoma and later (Tahoe 26 would be future version)
    ],
    products: [
        .executable(
            name: "CSVDataViewer",
            targets: ["CSVDataViewer"]
        )
    ],
    dependencies: [
        // SwiftUI Charts for data visualization
    ],
    targets: [
        .executableTarget(
            name: "CSVDataViewer",
            dependencies: [],
            path: "Sources/CSVDataViewer"
        ),
        .testTarget(
            name: "CSVDataViewerTests",
            dependencies: ["CSVDataViewer"]
        )
    ]
)
