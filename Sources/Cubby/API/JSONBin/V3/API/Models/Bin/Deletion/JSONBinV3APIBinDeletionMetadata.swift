// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Bin.Deletion {
	struct Metadata {
		public let id: Bin.ID
		public let versionDeletionCount: Int
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.Deletion.Metadata: Decodable {
	enum CodingKeys: String, CodingKey {
		case id
		case versionDeletionCount = "versionsDeleted"
	}
}
