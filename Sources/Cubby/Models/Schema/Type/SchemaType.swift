// Copyright © Fleuronic LLC. All rights reserved.

public enum SchemaType {
	case object
	case array
	case string
	case integer
	case number
	case boolean
	case null
	case optional(BaseValue)
}

// MARK: -
extension SchemaType {
	init(_ rawValue: BaseValue) {
		switch rawValue {
		case .object:
			self = .object
		case .array:
			self = .array
		case .string:
			self = .string
		case .integer:
			self = .integer
		case .number:
			self = .number
		case .boolean:
			self = .boolean
		case .null:
			self = .null
		}
	}

	var rawValue: BaseValue {
		switch self {
		case .object:
			return .object
		case .array:
			return .array
		case .string:
			return .string
		case .integer:
			return .integer
		case .number:
			return .number
		case .boolean:
			return .boolean
		case .null:
			return .null
		case let .optional(rawValue):
			return rawValue
		}
	}

	var isRequired: Bool {
		switch self {
		case .optional:
			return false
		default:
			return true
		}
	}
}

// MARK: -
extension SchemaType: Equatable {}
