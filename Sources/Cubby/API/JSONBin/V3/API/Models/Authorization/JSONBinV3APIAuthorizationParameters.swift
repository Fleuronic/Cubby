// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Authorization {
	struct Parameters {
		let secretKey: String?
	}
}

// MARK: -
extension JSONBin.V3.API.Authorization.Parameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case secretKey = "MasterKey"
	}
}
