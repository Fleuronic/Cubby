// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Cubby

struct Site {
	let httpURLString: String?
	let httpsURLString: String?
}

// MARK: -
extension Site: Equatable {}

extension Site: Codable {
	enum CodingKeys: CodingKey {
		case httpURLString
		case httpsURLString
	}
}

extension Site: SchemaAdhering {
	static var properties: [CodingKeys: SchemaType] {
		[
			.httpURLString: .optional(.string),
			.httpsURLString: .optional(.string)
		]
	}
}
