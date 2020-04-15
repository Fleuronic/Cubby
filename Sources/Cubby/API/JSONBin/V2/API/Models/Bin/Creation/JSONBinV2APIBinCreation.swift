// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V2.API.Bin {
	struct Creation<Resource: Decodable> {
		public let success: Bool
		public let resource: Resource
		public let id: Bin.ID
		public let isPrivate: Bool
		public let name: String?
		public let collectionID: Collection.ID?
	}
}

// MARK: -
extension JSONBin.V2.API.Bin.Creation: Decodable {
	enum CodingKeys: String, CodingKey {
		case success
		case resource = "data"
		case id
		case isPrivate = "private"
		case name = "binName"
		case collectionID
	}
}
