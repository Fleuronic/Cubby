// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

extension Schema: Codable {
	// MARK: Encodable
	public func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encodeIfPresent(id, forKey: .id)
		try container.encodeIfPresent(schemaURI, forKey: .schemaURI)
		try container.encodeIfPresent(title, forKey: .title)
		try container.encodeIfPresent(description, forKey: .description)
		try container.encodeIfPresent(type, forKey: .type)
		try container.encodeIfPresent(requiredPropertyNames?.map { $0.stringValue }, forKey: .requiredPropertyNameValues)

		var propertiesContainer = container.nestedContainer(keyedBy: Resource.CodingKeys.self, forKey: .properties)
		try properties?.forEach { key, value in
			var typeContainer = propertiesContainer.nestedContainer(keyedBy: SchemaType.CodingKeys.self, forKey: key)
			try typeContainer.encode(value.rawValue, forKey: .type)
		}
	}

	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decodeIfPresent(URL.self, forKey: .id)
		schemaURI = try container.decodeIfPresent(URL.self, forKey: .schemaURI)
		title = try container.decodeIfPresent(String.self, forKey: .title)
		description = try container.decodeIfPresent(String.self, forKey: .description)
		type = try container.decodeIfPresent(SchemaType.self, forKey: .type)

		let propertiesContainer = try? container.nestedContainer(keyedBy: Resource.CodingKeys.self, forKey: .properties)
		let requiredPropertyNameValues = try container.decodeIfPresent(Set<String>.self, forKey: .requiredPropertyNameValues)
		properties = try propertiesContainer.map { container in
			.init(
				uniqueKeysWithValues: try Resource.properties.keys.map { name in
					let typeContainer = try container.nestedContainer(keyedBy: SchemaType.CodingKeys.self, forKey: name)
					let rawValue = try typeContainer.decode(SchemaType.BaseValue.self, forKey: .type)
					let isRequired = requiredPropertyNameValues?.contains(name.stringValue) ?? false
					let type: SchemaType = isRequired ? .init(rawValue) : .optional(rawValue)
					return (name, type)
				}
			)
		}
	}
}

// MARK: -
private extension Schema {
	enum CodingKeys: String, CodingKey {
		case id = "$id"
		case schemaURI = "$schema"
		case title
		case description
		case type
		case properties
		case requiredPropertyNameValues = "required"
	}

	var requiredPropertyNames: Set<Resource.CodingKeys>? {
		properties.flatMap {
			let names = Set($0.filter { $1.isRequired }.keys)
			return names.isEmpty ? nil : names
		}
	}
}

// MARK: -
extension SchemaType {
	enum CodingKeys: String, CodingKey {
		case type
	}
}
