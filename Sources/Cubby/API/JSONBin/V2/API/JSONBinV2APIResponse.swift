// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V2.API {
	struct Response<Resource>: APIResponse {
		public let data: Resource
	}
}

// MARK: -
extension JSONBin.V2.API.Response: Decodable where Resource: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		data = try container.decode(Resource.self)
	}
}
