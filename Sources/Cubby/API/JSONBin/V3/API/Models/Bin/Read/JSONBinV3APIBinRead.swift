// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V3.API.Bin {
	struct Read<Resource: Decodable> {
		public let resource: Resource
		public let metadata: Metadata?
	}
}

// MARK: -
extension JSONBin.V3.API.Bin.Read: Decodable {
	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		do {
			resource = try container.decode(Resource.self)
			metadata = nil
		} catch {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			resource = try container.decode(Resource.self, forKey: .resource)
			metadata = try container.decode(Metadata.self, forKey: .metadata)
		}
	}
}

// MARK: -
private extension JSONBin.V3.API.Bin.Read {
	enum CodingKeys: String, CodingKey {
		case resource = "record"
		case metadata
	}
}
