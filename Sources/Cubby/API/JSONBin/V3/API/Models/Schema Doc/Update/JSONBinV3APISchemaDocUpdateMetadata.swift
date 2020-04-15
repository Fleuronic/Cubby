// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONBin.V3.API.SchemaDoc.Update {
	struct Metadata {
		public let id: SchemaDoc.ID
	}
}

// MARK: -
extension JSONBin.V3.API.SchemaDoc.Update.Metadata: Decodable {}
