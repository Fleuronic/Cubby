// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public extension JSONBin.V3.API.Collection.Creation {
	struct Metadata {
		public let name: String?
		public let creationDate: Date
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.Creation.Metadata: Decodable {
	// MARK: Decodable
	enum CodingKeys: String, CodingKey {
		case name
		case creationDate = "createdAt"
	}
}
