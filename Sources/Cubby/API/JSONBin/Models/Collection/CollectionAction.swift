// Copyright © Fleuronic LLC. All rights reserved.

import Identity

public extension Collection {
	enum Action {
		case updateName(String)
		case addSchemaDoc(id: SchemaDoc.ID)
		case removeSchemaDoc
	}
}
