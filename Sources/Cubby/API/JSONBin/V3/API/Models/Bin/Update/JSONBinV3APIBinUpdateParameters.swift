// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Bin {
	struct UpdateParameters {
		let versioning: Bool?
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.UpdateParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case versioning = "binVersioning"
	}
}
