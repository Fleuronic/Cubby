// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Collection {
	struct CreateParameters {
		let name: String?
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.CreateParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case name = "collectionName"
	}
}
