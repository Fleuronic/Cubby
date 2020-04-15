// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Collection.SchemaDoc {
	struct Removal {
		public let collectionName: String
		public let metadata: Metadata
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.SchemaDoc.Removal: Decodable {}
