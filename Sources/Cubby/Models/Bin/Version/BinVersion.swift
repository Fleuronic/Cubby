// Copyright © Fleuronic LLC. All rights reserved.

public extension Bin {
	enum Version {
		case latest
		case number(Int)
	}
}

// MARK: -
extension Bin.Version: Equatable {}
