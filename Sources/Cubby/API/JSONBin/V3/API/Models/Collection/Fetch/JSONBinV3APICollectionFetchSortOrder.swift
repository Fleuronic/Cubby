// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Collection.Fetch {
	enum SortOrder: String {
		case ascending
		case descending
	}
}

// MARK: -
extension JSONBin.V3.API.Collection.Fetch.SortOrder: Encodable {}
