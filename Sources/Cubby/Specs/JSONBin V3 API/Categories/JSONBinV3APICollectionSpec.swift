// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV3APICollectionSpec: JSONBinV3APISpec {
	func createCollection(named name: String) -> Request<Creation>
	func fetchBins(inCollectionWith id: ID, sortedBy sortOrder: Fetch.SortOrder?) -> Request<[Fetch.Result]>
	func fetchUncategorizedBins(sortedBy sortOrder: Fetch.SortOrder?) -> Request<[Fetch.Result]>
	func updateName(ofCollectionWith id: ID, toName name: String) -> Request<NameUpdate>
	func addSchemaDoc(with id: SchemaDoc.ID, toCollectionWith collectionID: ID) -> Request<Addition>
	func removeSchemaDoc(fromCollectionWith id: ID) -> Request<Removal>
}

// MARK: -
public extension JSONBinV3APICollectionSpec {
	typealias ID = Collection.ID
	typealias Creation = API.Collection.Creation
	typealias Fetch = API.Collection.Fetch
	typealias NameUpdate = API.Meta.Update<Collection, API.Collection.NameUpdateMetadata>
	typealias Addition = API.Collection.SchemaDoc.Addition
	typealias Removal = API.Collection.SchemaDoc.Removal
}
