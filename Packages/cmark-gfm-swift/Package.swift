// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "cmark-gfm-swift",
    products: [
        .library(name: "cmark-gfm-swift", targets: ["cmark-gfm-swift"]),
    ],
	dependencies: [
		.package(url: "https://github.com/swiftlang/swift-cmark", from: "0.5.0"),
	],
    targets: [
		.target(name: "cmark-gfm-swift", dependencies: [
			.product(name: "cmark-gfm", package: "swift-cmark"),
			.product(name: "cmark-gfm-extensions", package: "swift-cmark"),
		]),
    ]
)
