// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV2APIBinSpec: JSONBinV2APISpec {
	func createBin<Resource: Encodable>(named name: String?, with resource: Resource, inCollectionWith id: Collection.ID?, private: Bool?) -> Request<Creation<Resource>>
	func readBin<Resource: Decodable>(with id: ID, of type: Resource.Type, at version: Version?) -> Request<Resource>
	func updateBin<Resource: Encodable>(with id: ID, using resource: Resource, versioning: Bool?) -> Request<Update<Resource>>
	func deleteBin(with id: ID) -> Request<Deletion>
}

// MARK: -
extension JSONBinV2APIBinSpec {
	typealias CreateParameters = API.Bin.CreateParameters
	typealias UpdateParameters = API.Bin.UpdateParameters
}

// MARK: -
public extension JSONBinV2APIBinSpec {
	typealias ID = Bin.ID
	typealias Version = Bin.Version
	typealias Creation<Resource: Decodable> = API.Bin.Creation<Resource>
	typealias Update<Resource: Decodable> = API.Bin.Update<Resource>
	typealias Deletion = API.Bin.Deletion
}
