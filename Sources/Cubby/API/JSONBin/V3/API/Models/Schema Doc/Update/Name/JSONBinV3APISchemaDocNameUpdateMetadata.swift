// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.SchemaDoc.NameUpdate {
	struct Metadata {
		public let id: SchemaDoc.ID
		public let name: String
	}
}

// MARK: -
extension JSONBin.V3.API.SchemaDoc.NameUpdate.Metadata: Decodable {}
