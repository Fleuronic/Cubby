// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Identity

public struct Schema<Resource: SchemaAdhering> {
	public let id: URL?
	public let schemaURI: URL?
	public let title: String?
	public let description: String?
	public let type: SchemaType?
	public let properties: [Resource.CodingKeys: SchemaType]?
}
