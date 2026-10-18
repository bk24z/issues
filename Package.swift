// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Issues",
    platforms: [.macOS(.v14)],
    products: [
        // A droplet is a loadable bundle, so its product is a dynamic library.
        // Do not make it static: the app already carries DroppyKit, and a
        // second copy inside the droplet gives the same type two metadata
        // records, which fails every cast between them.
        .library(name: "Issues", type: .dynamic, targets: ["Issues"])
    ],
    dependencies: [
        .package(url: "https://gitlab.com/droppyformac1/droppykit.git", from: "1.6.0")
    ],
    targets: [
        .target(
            name: "Issues",
            dependencies: [.product(name: "DroppyKit", package: "droppykit")]
        ),
        .executableTarget(
            name: "IssuesHarness",
            dependencies: [
                "Issues",
                .product(name: "DroppyKitHarness", package: "droppykit")
            ]
        )
    ]
)
