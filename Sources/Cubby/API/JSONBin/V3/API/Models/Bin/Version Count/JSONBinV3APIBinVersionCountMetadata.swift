// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Bin.VersionCount {
	struct Metadata {
		public let id: Bin.ID
		public let versionCount: Int
		public let isPrivate: Bool
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.VersionCount.Metadata: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case id
		case versionCount
		case isPrivate = "private"
	}
}
