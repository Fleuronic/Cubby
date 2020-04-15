// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Collection.Fetch.Result {
	struct Metadata {
		public let name: String?
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.Fetch.Result.Metadata: Decodable {}
