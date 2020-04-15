// Copyright © Fleuronic LLC. All rights reserved.

import IPAddress

public enum IPAddress {
	case v4(IPv4Address)
	case v6(IPv6Address)
	case invalid(String)
}

// MARK: -
public extension IPAddress {
	var stringValue: String {
		switch self {
		case let .v4(value):
			return value.description
		case let .v6(value):
			return value.description
		case let .invalid(string):
			return string
		}
	}
}

// MARK: -
public extension IPAddress {
	init(_ string: String) {
		self =
			IPv4Address(string).map(IPAddress.v4) ??
			IPv6Address(string).map(IPAddress.v6) ??
			.invalid(string)
	}
}

// MARK: -
extension IPAddress: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(value)
	}
}
