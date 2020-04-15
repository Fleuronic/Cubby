// Copyright © Fleuronic LLC. All rights reserved.

extension JSONBin.V3.API: JSONBinV3APICollectionSpec {
	public func createCollection(named name: String) -> Request<JSONBinV3APICollectionSpec.Creation> {
		let path = Cubby.Collection.path
		let parameters = Collection.CreateParameters(name: name)
		return post(to: path, specifying: parameters)
	}

	public func fetchBins(inCollectionWith id: Cubby.Collection.ID, sortedBy sortOrder: Fetch.SortOrder? = nil) -> Request<[Fetch.Result]> {
		let path = Cubby.Collection.path(to: id, to: .bins)
		let parameters = Collection.Fetch.Parameters(sortOrder: sortOrder)
		return getResource(at: path, specifiedBy: parameters)
	}

	public func fetchUncategorizedBins(sortedBy sortOrder: Fetch.SortOrder? = nil) -> Request<[Fetch.Result]> {
		let subpath = Cubby.Collection.subpath(to: .uncategorized, .bins)
		let path = Cubby.Collection.path.appending(subpath)
		let parameters = Collection.Fetch.Parameters(sortOrder: sortOrder)
		return getResource(at: path, specifiedBy: parameters)
	}

	public func updateName(ofCollectionWith id: Cubby.Collection.ID, toName name: String) -> Request<JSONBinV3APICollectionSpec.NameUpdate> {
		let subpath = Meta.subpath(to: .name)
		let path = Cubby.Collection.path(to: id).appending(subpath)
		let parameters = Collection.NameUpdateParameters(name: name)
		return put(at: path, specifying: parameters)
	}

	public func addSchemaDoc(with id: Cubby.SchemaDoc.ID, toCollectionWith collectionID: Cubby.Collection.ID) -> Request<Addition> {
		let path = Cubby.Collection.path(to: collectionID, to: .schemaDoc, .add)
		let parameters = Collection.SchemaDoc.AddParameters(schemaDocID: id)
		return put(at: path, specifying: parameters)
	}

	public func removeSchemaDoc(fromCollectionWith id: Cubby.Collection.ID) -> Request<Removal> {
		let path = Cubby.Collection.path(to: id, to: .schemaDoc, .remove)
		return put(at: path)
	}
}
