// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V2.API.Bin {
	struct Deletion {
		public let success: Bool
		public let id: Bin.ID
		public let message: String
	}
}

// MARK: -
extension JSONBin.V2.API.Bin.Deletion: Decodable {}
