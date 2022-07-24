// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sparql-client",
	platforms: [.macOS(.v10_15)],
    dependencies: [
		.package(url: "https://github.com/kasei/kineo.git", .upToNextMinor(from: "0.0.103")),
    ],
    targets: [
        .executableTarget(
            name: "sparql-client",
            dependencies: [
            	.product(name: "Kineo", package: "kineo")
            ])
    ]
)
