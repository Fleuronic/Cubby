// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Emissary
import Skewer

public extension JSONBin.V2 {
	struct API {
		private let secretKey: String?

		public init(secretKey: String? = nil) {
			self.secretKey = secretKey
		}
	}
}

// MARK: -
public extension JSONBin.V2.API {
	typealias Request<Resource> = Emissary.Request<Response<Resource>, Self>
	typealias Result<Resource> = Swift.Result<Resource, NetworkError<Error>>
}

// MARK: -
extension JSONBin.V2.API: API {
	// MARK: API
	public var baseURL: URL {
		"https://api.jsonbin.io"
	}

	public var customHeaderParameters: Authorization.Parameters {
		.init(secretKey: secretKey)
	}

	public static var dateFormat: String? {
		"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
	}

	public static var codingStrategy: CodingStrategy {
		.init(
			keyDecodingStrategy: .useDefaultKeys,
			keyEncodingStrategy: [
				.parameters: .convertToKebabCase(componentTransform: .lowercase),
				.payload: .useDefaultKeys
			]
		)
	}
}
