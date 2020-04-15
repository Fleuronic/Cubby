// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Cubby

struct Person {
	let name: String
	let nickname: String?
	let age: Int

	init(
		name: String,
		nickname: String? = nil,
		age: Int
	) {
		self.name = name
		self.nickname = nickname
		self.age = age
	}
}

// MARK: -
extension Person: Equatable {}

extension Person: Codable {
	enum CodingKeys: CodingKey {
		case name
		case age
		case nickname
	}
}

extension Person: SchemaAdhering {
	static var id: URL? {
		"http://example.com/person.schema.json"
	}

	static var schemaURI: URL? {
		"http://json-schema.org/draft-07/schema#"
	}

	static var description: String? {
		"A person object."
	}

	static var properties: [CodingKeys: SchemaType] {
		[
			.name: .string,
			.nickname: .optional(.string),
			.age: .integer
		]
	}
}
