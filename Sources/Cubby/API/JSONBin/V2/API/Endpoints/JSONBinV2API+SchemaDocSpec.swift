// Copyright © Fleuronic LLC. All rights reserved.

extension JSONBin.V2.API: JSONBinV2APISchemaDocSpec {
	public func createSchemaDoc<Resource>(for type: Resource.Type, named name: String) -> Request<SchemaDocResponse<Resource>> {
		let path = Cubby.SchemaDoc.path
		let parameters = SchemaDoc.CreateParameters(name: name)
		return post(Resource.schema, to: path, specifying: parameters)
	}

	public func readSchemaDoc<Resource>(with id: Cubby.SchemaDoc.ID, for type: Resource.Type) -> Request<Schema<Resource>> {
		let path = Cubby.SchemaDoc.path(to: id)
		return getResource(at: path)
	}

	public func updateSchemaDoc<Resource>(with id: Cubby.SchemaDoc.ID, toSchemaFor type: Resource.Type) -> Request<SchemaDocResponse<Resource>> {
		let path = Cubby.SchemaDoc.path(to: id)
		return put(Resource.schema, at: path)
	}
}
