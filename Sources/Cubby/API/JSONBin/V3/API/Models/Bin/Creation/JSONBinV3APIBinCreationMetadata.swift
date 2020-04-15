// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONBin.V3.API.Bin.Creation {
	struct Metadata {
		public let id: Bin.ID
		public let name: String?
		public let creationDate: Date
		public let isPrivate: Bool
		public let collectionID: Collection.ID?
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.Creation.Metadata: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case creationDate = "createdAt"
		case isPrivate = "private"
		case collectionID = "collectionId"
	}
}
