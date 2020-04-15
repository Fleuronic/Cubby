// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Bin {
	struct ReadParameters {
		let includeMetadata: Bool?
		let dotPath: String?
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.ReadParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case includeMetadata = "binMeta"
		case dotPath
	}
}
