// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Bin {
	struct CreateParameters {
		let name: String?
		let `private`: Bool?
		let collectionID: Collection.ID?
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.CreateParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case name = "binName"
		case `private` = "binPrivate"
		case collectionID
	}
}
