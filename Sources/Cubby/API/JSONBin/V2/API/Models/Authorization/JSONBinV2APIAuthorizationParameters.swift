// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V2.API.Authorization {
	struct Parameters {
		let secretKey: String?
	}
}

// MARK: -
extension JSONBin.V2.API.Authorization.Parameters: Parameters {}
