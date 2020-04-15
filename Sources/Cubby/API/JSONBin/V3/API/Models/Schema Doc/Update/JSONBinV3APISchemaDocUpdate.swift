// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.SchemaDoc {
	struct Update<Resource: SchemaAdhering> {
		public let schema: Schema<Resource>
		public let metadata: Metadata
	}
}

// MARK: -
extension JSONBin.V3.API.SchemaDoc.Update: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case schema = "record"
		case metadata
	}
}
