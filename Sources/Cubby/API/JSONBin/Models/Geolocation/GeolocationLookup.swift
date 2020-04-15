// Copyright © Fleuronic LLC. All rights reserved.

public extension Geolocation {
	struct Lookup {
		public let success: Bool
		public let data: Geolocation
		public let ipAddressString: String
	}
}

// MARK: -
extension Geolocation.Lookup: Decodable {
	enum CodingKeys: String, CodingKey {
		case success
		case data
		case ipAddressString = "searchedFor"
	}
}
