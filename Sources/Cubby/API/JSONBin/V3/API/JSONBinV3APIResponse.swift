// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Emissary

public extension JSONBin.V3.API {
	struct Response<Resource>: APIResponse {
		public let data: Resource
	}
}

// MARK: -
extension JSONBin.V3.API.Response: Decodable where Resource: Decodable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		data = try container.decode(Resource.self)
	}
}

extension JSONBin.V3.API.Response: DataDecodable where Resource: DataDecodable {
	public init(from data: Data) {
		self.data = .init(from: data)
	}
}
