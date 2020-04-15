// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.SchemaDoc {
	struct NameUpdateParameters {
		let name: String
	}
}

// MARK: -
extension JSONBin.V3.API.SchemaDoc.NameUpdateParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case name = "schemaDocName"
	}
}
