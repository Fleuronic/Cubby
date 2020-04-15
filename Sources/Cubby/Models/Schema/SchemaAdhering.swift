// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public protocol SchemaAdhering: Codable {
	associatedtype CodingKeys: CodingKey, Hashable

	static var id: URL? { get }
	static var schemaURI: URL? { get }
	static var description: String? { get }
	static var properties: [CodingKeys: SchemaType] { get }
}

// MARK: -
public extension SchemaAdhering {
	static var id: URL? { nil }
	static var schemaURI: URL? { nil }
	static var description: String? { nil }

	static var schema: Schema<Self> {
		.init(
			id: id,
			schemaURI: schemaURI,
			title: .init(describing: self),
			description: description,
			type: .object,
			properties: properties
		)
	}
}
