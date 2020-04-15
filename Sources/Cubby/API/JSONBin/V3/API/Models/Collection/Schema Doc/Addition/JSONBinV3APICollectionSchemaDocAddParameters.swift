// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API.Collection.SchemaDoc {
	struct AddParameters {
		let schemaDocID: SchemaDoc.ID
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.SchemaDoc.AddParameters: Parameters {
	// MARK: Encodable
	enum CodingKeys: String, CodingKey {
		case schemaDocID = "schemaDocId"
	}
}
