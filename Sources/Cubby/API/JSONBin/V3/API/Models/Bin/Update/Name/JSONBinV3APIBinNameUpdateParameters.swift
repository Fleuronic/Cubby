// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Bin {
	struct NameUpdateParameters {
		let name: String
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.NameUpdateParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case name = "binName"
	}
}
