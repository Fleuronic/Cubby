// Copyright © Fleuronic LLC. All rights reserved.

extension Bin.Version: Decodable {
	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let number = try container.decode(Int.self)
		self = .number(number)
	}
}
