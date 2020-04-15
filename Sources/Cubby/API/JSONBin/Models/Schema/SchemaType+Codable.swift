// Copyright © Fleuronic LLC. All rights reserved.

extension SchemaType: Codable {
	// MARK: Encodable
	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}

	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(BaseValue.self)
		self = .init(rawValue)
	}
}

// MARK: -
extension SchemaType.BaseValue: Codable {}
