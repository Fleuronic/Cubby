// Copyright © Fleuronic LLC. All rights reserved.

import Cubby

struct User {
	let username: String
	let password: String?
	let isLoggedIn: Bool
	let previousUsernames: [String]?
	let highScore: Double?
}

// MARK: -
extension User: Equatable {}

extension User: Codable {
	enum CodingKeys: CodingKey {
		case username
		case password
		case isLoggedIn
		case previousUsernames
		case highScore
	}
}

extension User: SchemaAdhering {
	static var properties: [CodingKeys: SchemaType] {
		[
			.username: .string,
			.password: .null,
			.isLoggedIn: .boolean,
			.previousUsernames: .array,
			.highScore: .number
		]
	}
}
