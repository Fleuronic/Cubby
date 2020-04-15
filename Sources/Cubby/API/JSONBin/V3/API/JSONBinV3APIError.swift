// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API {
	struct Error {
		public let message: String
		public let schemaDocID: Cubby.SchemaDoc.ID?
		public let schemaDocName: String?
	}
}

// MARK: -
extension JSONBin.V3.API.Error: APIError {}
