// swift-tools-version:5.3
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

var targets: [Target] = [
	.target(
		name: "Cubby",
		dependencies: [
			"Emissary",
			"Skewer",
			"Identity",
			.product(name: "IPAddress", package: "SwiftIPAddress")
		]
	)
]

#if !(os(watchOS) && swift(<5.4))
targets.append(
	.testTarget(
		name: "CubbyTests",
		dependencies: ["Cubby"],
		resources: [
			.process("API/JSONBin/V2/API/Fixtures"),
			.process("API/JSONBin/V3/API/Fixtures"),
			.process("Models/Fixtures")
		]
	)
)
#endif

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
		.package(url: "https://github.com/Fleuronic/Emissary", from: "0.4.0"),
		.package(url: "https://github.com/Fleuronic/Skewer", from: "3.0.0"),
		.package(url: "https://github.com/JohnSundell/Identity", from: "0.1.0"),
		.package(url: "https://github.com/vkill/SwiftIPAddress", .branch("master"))
	],
	targets: targets
)
