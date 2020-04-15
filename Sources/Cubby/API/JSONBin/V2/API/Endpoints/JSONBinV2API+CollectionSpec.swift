// Copyright © Fleuronic LLC. All rights reserved.

extension JSONBin.V2.API: JSONBinV2APICollectionSpec {
	public func createCollection(named name: String) -> Request<Collection.Creation> {
		let path = Cubby.Collection.path
		let details = Details(name: name)
		return post(details, to: path)
	}

	public func updateCollection(with id: Cubby.Collection.ID, using action: Action) -> Request<Collection.Update> {
		let path = Cubby.Collection.path(to: id)

		switch action {
		case .updateName(let name):
			let details = Details(name: name)
			return put(details, at: path)
		case .addSchemaDoc(let id):
			let details = Details()
			let parameters = UpdateParameters(schemaDocID: id)
			return put(details, at: path, specifying: parameters)
		case .removeSchemaDoc:
			let details = Details()
			let parameters = UpdateParameters(removeSchemaDoc: true)
			return put(details, at: path, specifying: parameters)
		}
	}
}
