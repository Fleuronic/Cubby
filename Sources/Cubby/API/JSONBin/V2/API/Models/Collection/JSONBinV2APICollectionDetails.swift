// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V2.API.Collection {
	struct Details {
		public let name: String?
	}
}

// MARK: -
extension JSONBin.V2.API.Collection.Details {
	init() {
		name = nil
	}
}

// MARK: -
extension JSONBin.V2.API.Collection.Details: Codable {}
