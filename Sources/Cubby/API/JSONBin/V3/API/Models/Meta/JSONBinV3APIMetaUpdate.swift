// Copyright © Fleuronic LLC. All rights reserved.

import Identity

public extension JSONBin.V3.API.Meta {
	struct Update<Resource: Identifiable, Metadata: Decodable> where Resource.RawIdentifier: Codable {
		public let id: Resource.ID
		public let metadata: Metadata
	}
}

// MARK: -
extension JSONBin.V3.API.Meta.Update: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case id = "record"
		case metadata
	}
}
