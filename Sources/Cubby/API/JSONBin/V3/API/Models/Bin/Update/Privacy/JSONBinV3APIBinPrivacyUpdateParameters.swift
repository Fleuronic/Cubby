// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Bin {
	struct PrivacyUpdateParameters {
		let `private`: Bool
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.PrivacyUpdateParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case `private` = "binPrivate"
	}
}
