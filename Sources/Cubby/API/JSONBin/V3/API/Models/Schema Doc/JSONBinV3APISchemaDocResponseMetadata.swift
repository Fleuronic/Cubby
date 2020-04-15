// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONBin.V3.API.SchemaDoc.Response {
	struct Metadata {
		public let id: SchemaDoc.ID
		public let name: String
		public let creationDate: Date
	}
}

// MARK: -
extension JSONBin.V3.API.SchemaDoc.Response.Metadata: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case creationDate = "createdAt"
	}
}
