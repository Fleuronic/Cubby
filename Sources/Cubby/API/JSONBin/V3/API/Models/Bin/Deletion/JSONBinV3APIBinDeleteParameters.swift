// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Bin {
	struct DeleteVersionParameters {
		let preserveLatest: Bool?
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.DeleteVersionParameters: Parameters {}
