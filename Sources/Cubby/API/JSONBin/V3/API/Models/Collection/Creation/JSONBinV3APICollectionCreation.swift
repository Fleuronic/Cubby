// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Collection {
	struct Creation {
		public let id: Collection.ID
		public let metadata: Metadata
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.Creation: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case id = "record"
		case metadata
	}
}
