// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Bin {
	struct Deletion {
		public let message: String
		public let metadata: Metadata?
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.Deletion: Decodable {
	enum CodingKeys: String, CodingKey {
		case message
		case metadata
		case metaData
	}

	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		message = try container.decode(String.self, forKey: .message)
		metadata = try container.decodeIfPresent(Metadata.self, forKey: .metadata) ??
			container.decodeIfPresent(Metadata.self, forKey: .metaData)
	}
}
