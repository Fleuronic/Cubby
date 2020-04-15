// Copyright © Fleuronic LLC. All rights reserved.

extension JSONBin.V3.API: JSONBinV3APIBinSpec {
	public func createBin<Resource: Encodable>(named name: String? = nil, with resource: Resource, inCollectionWith id: Cubby.Collection.ID? = nil, private: Bool? = nil) -> Request<Bin.Creation<Resource>> {
		let path = Cubby.Bin.path
		let parameters = Bin.CreateParameters(
			name: name,
			private: `private`,
			collectionID: id
		)

		return post(resource, to: path, specifying: parameters)
	}

	public func readBin<Resource: Decodable>(with id: Cubby.Bin.ID, of type: Resource.Type, at version: Cubby.Bin.Version? = nil, includingMetadata: Bool? = nil, usingDotPath dotPath: String? = nil) -> Request<Read<Resource>> {
		let path = Cubby.Bin.path(to: id).appending(version)
		let parameters = Bin.ReadParameters(
			includeMetadata: includingMetadata,
			dotPath: dotPath
		)

		return getResource(at: path, specifiedBy: parameters)
	}

	public func versionCount(ofBinWith id: Cubby.Bin.ID) -> Request<Bin.VersionCount> {
		let subpath = Cubby.Bin.Version.subpath(to: .count)
		let path = Cubby.Bin.path(to: id).appending(subpath)
		return getResource(at: path)
	}

	public func updateBin<Resource: Encodable>(with id: Cubby.Bin.ID, using resource: Resource, versioning: Bool? = nil) -> Request<Bin.Update<Resource>> {
		let path = Cubby.Bin.path(to: id)
		let parameters = Bin.UpdateParameters(versioning: versioning)
		return put(resource, at: path, specifying: parameters)
	}

	public func updateName(ofBinWith id: Cubby.Bin.ID, toName name: String) -> Request<JSONBinV3APIBinSpec.NameUpdate> {
		let subpath = Meta.subpath(to: .name)
		let path = Cubby.Bin.path(to: id).appending(subpath)
		let parameters = Bin.NameUpdateParameters(name: name)
		return put(at: path, specifying: parameters)
	}

	public func updatePrivacy(ofBinWith id: Cubby.Bin.ID, toPrivate private: Bool) -> Request<PrivacyUpdate> {
		let subpath = Meta.subpath(to: .privacy)
		let path = Cubby.Bin.path(to: id).appending(subpath)
		let parameters = Bin.PrivacyUpdateParameters(private: `private`)
		return put(at: path, specifying: parameters)
	}

	public func deleteBin(with id: Cubby.Bin.ID) -> Request<Deletion> {
		let path = Cubby.Bin.path(to: id)
		return deleteResource(at: path)
	}

	public func deleteVersions(ofBinWith id: Cubby.Bin.ID, preservingLatest: Bool? = nil) -> Request<Deletion> {
		let subpath = Cubby.Bin.Version.subpath
		let path = Cubby.Bin.path(to: id).appending(subpath)
		let parameters = Bin.DeleteVersionParameters(preserveLatest: preservingLatest)
		return deleteResource(at: path, specifying: parameters)
	}
}
