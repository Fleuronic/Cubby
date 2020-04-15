// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV3APISchemaDocSpec: JSONBinV3APISpec {
	func createSchemaDoc<Resource>(for type: Resource.Type, named name: String) -> Request<Response<Resource>>
	func readSchemaDoc<Resource>(with id: ID, for type: Resource.Type) -> Request<Response<Resource>>
	func updateSchemaDoc<Resource>(with id: ID, toSchemaFor type: Resource.Type) -> Request<Update<Resource>>
	func updateName(ofSchemaDocWith id: ID, toName name: String) -> Request<NameUpdate>
}

// MARK: -
public extension JSONBinV3APISchemaDocSpec {
	typealias ID = SchemaDoc.ID
	typealias Response<Resource: SchemaAdhering> = API.SchemaDoc.Response<Resource>
	typealias Update<Resource: SchemaAdhering> = API.SchemaDoc.Update<Resource>
	typealias NameUpdate = API.SchemaDoc.NameUpdate
}
