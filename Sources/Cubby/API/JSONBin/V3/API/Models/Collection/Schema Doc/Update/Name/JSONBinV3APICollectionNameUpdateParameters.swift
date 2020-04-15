// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Collection {
	struct NameUpdateParameters {
		let name: String
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.NameUpdateParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case name = "collectionName"
	}
}
