// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V2.API {
	struct Error {
		public let message: String
		public let success: Bool?
		public let schemaDocID: Cubby.SchemaDoc.ID?
		public let schemaDocName: String?
	}
}

// MARK: -
extension JSONBin.V2.API.Error: APIError {}
