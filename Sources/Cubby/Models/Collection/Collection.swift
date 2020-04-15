// Copyright © Fleuronic LLC. All rights reserved.

import Identity

public struct Collection {
	public let id: ID
}

// MARK: -
extension Collection: Decodable {}

extension Collection: Identifiable {}
