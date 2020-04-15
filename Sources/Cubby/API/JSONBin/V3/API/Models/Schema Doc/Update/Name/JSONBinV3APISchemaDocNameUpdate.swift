// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.SchemaDoc {
	struct NameUpdate {
		public let metadata: Metadata
	}
}

// MARK: -
extension JSONBin.V3.API.SchemaDoc.NameUpdate: Decodable {}
