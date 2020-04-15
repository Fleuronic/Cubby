// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Bin {
	struct PrivacyUpdateMetadata {
		public let isPrivate: Bool
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.PrivacyUpdateMetadata: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case isPrivate = "private"
	}
}
