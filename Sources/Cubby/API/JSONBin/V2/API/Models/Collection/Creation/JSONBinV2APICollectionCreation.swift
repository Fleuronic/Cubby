// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V2.API.Collection {
	struct Creation {
		public let success: Bool
		public let id: Collection.ID
		public let details: Details
	}
}

// MARK: -
extension JSONBin.V2.API.Collection.Creation: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case success
		case id
		case details = "data"
	}
}
