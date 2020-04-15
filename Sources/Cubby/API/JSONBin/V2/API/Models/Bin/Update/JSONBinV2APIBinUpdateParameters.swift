// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V2.API.Bin {
	struct UpdateParameters {
		let versioning: Bool?
	}
}

// MARK: -
extension JSONBin.V2.API.Bin.UpdateParameters: Parameters {}
