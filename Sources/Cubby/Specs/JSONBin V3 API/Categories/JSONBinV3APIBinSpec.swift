// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV3APIBinSpec: JSONBinV3APISpec {
	func createBin<Resource: Encodable>(named name: String?, with resource: Resource, inCollectionWith id: Collection.ID?, private: Bool?) -> Request<Creation<Resource>>
	func readBin<Resource: Decodable>(with id: ID, of type: Resource.Type, at version: Version?, includingMetadata: Bool?, usingDotPath dotPath: String?) -> Request<Read<Resource>>
	func versionCount(ofBinWith id: ID) -> Request<VersionCount>
	func updateBin<Resource: Encodable>(with id: ID, using resource: Resource, versioning: Bool?) -> Request<Update<Resource>>
	func updateName(ofBinWith id: ID, toName name: String) -> Request<NameUpdate>
	func updatePrivacy(ofBinWith id: ID, toPrivate private: Bool) -> Request<PrivacyUpdate>
	func deleteBin(with id: ID) -> Request<Deletion>
	func deleteVersions(ofBinWith id: ID, preservingLatest: Bool?) -> Request<Deletion>
}

// MARK: -
public extension JSONBinV3APIBinSpec {
	typealias ID = Bin.ID
	typealias Version = Bin.Version
	typealias Creation<Resource: Decodable> = API.Bin.Creation<Resource>
	typealias Read<Resource: Decodable> = API.Bin.Read<Resource>
	typealias Update<Resource: Decodable> = API.Bin.Update<Resource>
	typealias NameUpdate = API.Meta.Update<Bin, API.Bin.NameUpdateMetadata>
	typealias PrivacyUpdate = API.Meta.Update<Bin, API.Bin.PrivacyUpdateMetadata>
	typealias Deletion = API.Bin.Deletion
	typealias VersionCount = API.Bin.VersionCount
}
