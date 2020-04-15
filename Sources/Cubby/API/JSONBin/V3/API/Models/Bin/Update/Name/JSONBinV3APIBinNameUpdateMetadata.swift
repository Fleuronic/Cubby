// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Bin {
	struct NameUpdateMetadata {
		public let name: String
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.NameUpdateMetadata: Decodable {}
