// Copyright © Fleuronic LLC. All rights reserved.

extension Experimental.Request.Count: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		value = try container.decode(Int.self, forKey: .value)
	}
}

// MARK: -
private extension Experimental.Request.Count {
	enum CodingKeys: String, CodingKey {
		case value = "count"
	}
}
