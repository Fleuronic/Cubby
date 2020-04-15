// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV2APICollectionSpec: JSONBinV2APISpec {
	func createCollection(named name: String) -> Request<Creation>
	func updateCollection(with id: ID, using action: Action) -> Request<Update>
}

// MARK: -
extension JSONBinV2APICollectionSpec {
	typealias Details = API.Collection.Details
	typealias UpdateParameters = API.Collection.UpdateParameters
}

// MARK: -
public extension JSONBinV2APICollectionSpec {
	typealias ID = Collection.ID
	typealias Creation = API.Collection.Creation
	typealias Update = API.Collection.Update
	typealias Action = Collection.Action
}
