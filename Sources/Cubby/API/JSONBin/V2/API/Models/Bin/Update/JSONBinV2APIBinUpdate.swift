// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V2.API.Bin {
	struct Update<Resource: Decodable> {
		public let success: Bool
		public let resource: Resource
		public let parentID: Bin.ID
		public let version: Bin.Version?
	}
}

// MARK: -
extension JSONBin.V2.API.Bin.Update: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case success
		case resource = "data"
		case version
		case parentID = "parentId"
	}
}
