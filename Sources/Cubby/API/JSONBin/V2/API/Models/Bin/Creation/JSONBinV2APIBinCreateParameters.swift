// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V2.API.Bin {
	struct CreateParameters {
		let name: String?
		let `private`: Bool?
		let collectionID: Collection.ID?
	}
}

// MARK: -
extension JSONBin.V2.API.Bin.CreateParameters: Parameters {}
