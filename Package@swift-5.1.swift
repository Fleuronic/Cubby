// swift-tools-version:5.1
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

let package = Package(
	name: "Cubby",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.watchOS(.v6),
		.tvOS(.v13)
	],
	products: [
		.library(
			name: "Cubby",
			targets: ["Cubby"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Emissary", from: "0.1.0"),
		.package(url: "https://github.com/Fleuronic/Skewer", from: "1.1.0"),
		.package(url: "https://github.com/JohnSundell/Identity", from: "0.1.0"),
		.package(url: "https://github.com/Fleuronic/SwiftIPAddress", .branch("master"))
	],
	targets: [
		.target(
			name: "Cubby",
			dependencies: [
				"Emissary",
				"Skewer",
				"Identity",
				"IPAddress"
			]
		)
	]
)
