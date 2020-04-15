// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Collection.SchemaDoc {
	struct Addition {
		public let id: SchemaDoc.ID
		public let collectionName: String
		public let metadata: Metadata
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.SchemaDoc.Addition: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case id = "schemaDocId"
		case collectionName
		case metadata
	}
}
