// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Bin {
	struct VersionCount {
		public let metadata: Metadata
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.VersionCount: Decodable {
	enum CodingKeys: String, CodingKey {
		case metadata = "metaData"
	}
}
