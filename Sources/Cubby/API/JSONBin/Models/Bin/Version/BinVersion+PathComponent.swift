// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

extension Bin.Version: PathComponent {
	// MARK: PathComponent
	public var rawValue: String {
		switch self {
		case .latest:
			return Name.latest.rawValue
		case let .number(number):
			return .init(describing: number)
		}
	}
}
