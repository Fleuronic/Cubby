// Copyright © Fleuronic LLC. All rights reserved.

extension JSONBin.V2.API: JSONBinV2APIBinSpec {
	public func createBin<Resource: Encodable>(named name: String? = nil, with resource: Resource, inCollectionWith id: Cubby.Collection.ID? = nil, private: Bool? = nil) -> Request<Bin.Creation<Resource>> {
		let path = Cubby.Bin.path
		let parameters = CreateParameters(
			name: name,
			private: `private`,
			collectionID: id
		)

		return post(resource, to: path, specifying: parameters)
	}

	public func readBin<Resource: Decodable>(with id: Cubby.Bin.ID, of type: Resource.Type, at version: Cubby.Bin.Version? = nil) -> Request<Resource> {
		let path = Cubby.Bin.path(to: id).appending(version)
		return getResource(at: path)
	}

	public func updateBin<Resource: Encodable>(with id: Cubby.Bin.ID, using resource: Resource, versioning: Bool? = nil) -> Request<Bin.Update<Resource>> {
		let path = Cubby.Bin.path(to: id)
		let parameters = UpdateParameters(versioning: versioning)
		return put(resource, at: path, specifying: parameters)
	}

	public func deleteBin(with id: Cubby.Bin.ID) -> Request<Deletion> {
		let path = Cubby.Bin.path(to: id)
		return deleteResource(at: path)
	}
}
