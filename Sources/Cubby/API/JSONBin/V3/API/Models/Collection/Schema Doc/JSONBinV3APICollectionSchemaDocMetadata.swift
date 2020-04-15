// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONBin.V3.API.Collection.SchemaDoc {
	struct Metadata {
		public let id: Collection.ID
		public let creationDate: Date
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.SchemaDoc.Metadata: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case id
		case creationDate = "createdAt"
	}
}
