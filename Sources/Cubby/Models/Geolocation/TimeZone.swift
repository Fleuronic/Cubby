// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

extension TimeZone: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self = .init(identifier: value)!
	}
}
