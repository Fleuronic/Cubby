// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Bin.Update {
	struct Metadata {
		public let parentID: Bin.ID
		public let isPrivate: Bool
		public let version: Bin.Version?
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.Update.Metadata: Decodable {
	enum CodingKeys: String, CodingKey {
		case parentID = "parentId"
		case isPrivate = "private"
		case version
	}
}
