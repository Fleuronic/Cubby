// Copyright © Fleuronic LLC. All rights reserved.

import Identity

public struct Bin {
	public let id: ID
}

// MARK: -
extension Bin: Decodable {}

extension Bin: Identifiable {}
