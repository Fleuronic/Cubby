// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V2.API.SchemaDoc {
	struct Response<Resource: SchemaAdhering> {
		public let success: Bool
		public let data: Schema<Resource>
		public let id: SchemaDoc.ID
	}
}

// MARK: -
extension JSONBin.V2.API.SchemaDoc.Response: Decodable {}
