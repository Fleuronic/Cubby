// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Collection {
	struct NameUpdateMetadata {
		public let name: String
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.NameUpdateMetadata: Decodable {}
