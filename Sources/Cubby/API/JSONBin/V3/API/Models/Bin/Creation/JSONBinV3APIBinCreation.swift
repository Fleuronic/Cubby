// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Bin {
	struct Creation<Resource: Decodable> {
		public let resource: Resource
		public let metadata: Metadata
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.Creation: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case resource = "record"
		case metadata
	}
}
