// swift-tools-version:5.6

import PackageDescription

let package = Package(
  name: "swift-markdown-ui",
  platforms: [
    .macOS(.v12),
    .iOS(.v15),
    .tvOS(.v15),
    .macCatalyst(.v15),
    .watchOS(.v8),
  ],
  products: [
    .library(name: "MarkdownUI", targets: ["MarkdownUI", "Markdown"]),
  ],
  dependencies: [
    .package(url: "https://github.com/gonzalezreal/NetworkImage", from: "6.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.10.0"),
  ],
  targets: [
    .target(name: "CAtomic"),
    .target(name: "cmark-gfm",
            exclude: [
        "CMakeLists.txt",
        "ext_scanners.re",
        "scanners.re",
        "libcmark-gfm.pc.in",
        "config.h.in",
        "CMakeLists.txt",
        "cmark-gfm_version.h.in",
     ]),
    .target(name: "Markdown",
        dependencies: [
            "CAtomic",
            "cmark-gfm",
        ]),
    .target(
      name: "MarkdownUI",
      dependencies: [
        "cmark-gfm",
        .product(name: "NetworkImage", package: "NetworkImage"),
      ]
    ),
    .testTarget(
      name: "MarkdownUITests",
      dependencies: [
        "MarkdownUI",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ],
      exclude: ["__Snapshots__"]
    ),
  ]
)
