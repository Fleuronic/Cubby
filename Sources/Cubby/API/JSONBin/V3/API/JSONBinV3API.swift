// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Emissary
import Skewer

public extension JSONBin.V3 {
	struct API {
		private let secretKey: String?

		public init(secretKey: String? = nil) {
			self.secretKey = secretKey
		}
	}
}

// MARK: -
public extension JSONBin.V3.API {
	typealias Request<Resource> = Emissary.Request<Response<Resource>, Self>
	typealias Result<Resource> = Swift.Result<Resource, NetworkError<Error>>
}

// MARK: -
extension JSONBin.V3.API: API {
	// MARK: API
	public var baseURL: URL {
		"https://api.jsonbin.io/v3"
	}

	public var customHeaderParameters: JSONBin.V3.API.Authorization.Parameters {
		.init(secretKey: secretKey)
	}

	public var prefersHeaderParameters: Bool {
		true
	}

	public static var dateFormat: String? {
		"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	}

	public static var codingStrategy: CodingStrategy {
		.init(
			keyDecodingStrategy: .useDefaultKeys,
			keyEncodingStrategy: [
				.parameters: .convertToKebabCase(componentTransform: .capitalize(prefix: true)),
				.payload: .useDefaultKeys
			]
		)
	}
}
