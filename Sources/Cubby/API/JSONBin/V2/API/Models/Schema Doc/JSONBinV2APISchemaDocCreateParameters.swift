// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V2.API.SchemaDoc {
	struct CreateParameters {
		let name: String
	}
}

// MARK: -
extension JSONBin.V2.API.SchemaDoc.CreateParameters: Parameters {}
