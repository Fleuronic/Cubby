// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV2APISchemaDocSpec: JSONBinV2APISpec {
	func createSchemaDoc<Resource>(for type: Resource.Type, named name: String) -> Request<Response<Resource>>
	func readSchemaDoc<Resource>(with id: ID, for type: Resource.Type) -> Request<Schema<Resource>>
	func updateSchemaDoc<Resource>(with id: ID, toSchemaFor type: Resource.Type) -> Request<Response<Resource>>
}

// MARK: -
public extension JSONBinV2APISchemaDocSpec {
	typealias ID = SchemaDoc.ID
	typealias Response<Resource: SchemaAdhering> = API.SchemaDoc.Response<Resource>
}
