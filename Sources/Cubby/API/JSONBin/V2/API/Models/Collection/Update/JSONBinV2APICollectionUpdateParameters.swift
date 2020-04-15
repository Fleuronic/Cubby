// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

extension JSONBin.V2.API.Collection {
	struct UpdateParameters {
		let schemaDocID: SchemaDoc.ID?
		let removeSchemaDoc: Bool?

		init(
			schemaDocID: SchemaDoc.ID? = nil,
			removeSchemaDoc: Bool? = nil
		) {
			self.schemaDocID = schemaDocID
			self.removeSchemaDoc = removeSchemaDoc
		}
	}
}

// MARK: -
extension JSONBin.V2.API.Collection.UpdateParameters: Parameters {}
