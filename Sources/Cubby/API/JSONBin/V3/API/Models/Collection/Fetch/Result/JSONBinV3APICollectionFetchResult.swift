// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONBin.V3.API.Collection.Fetch {
	struct Result {
		public let id: Bin.ID
		public let isPrivate: Bool
		public let creationDate: Date
		public let metadata: Metadata
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.Fetch.Result: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case id = "record"
		case isPrivate = "private"
		case creationDate = "createdAt"
		case metadata = "snippetMeta"
	}
}
