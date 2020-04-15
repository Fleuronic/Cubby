// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.SchemaDoc {
	struct CreateParameters {
		let name: String
	}
}

// MARK: -
extension JSONBin.V3.API.SchemaDoc.CreateParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case name = "schemaDocName"
	}
}
