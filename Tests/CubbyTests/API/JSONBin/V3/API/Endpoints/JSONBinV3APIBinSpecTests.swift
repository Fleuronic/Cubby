// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Cubby

#if swift(>=5.5)
	#if swift(<5.5.2)
		@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	#endif
	final class JSONBinV3APIBinSpecTests: XCTestCase {
		func testCreateBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let person = Person(name: "Vaibhav", age: 30)
			let request = api.createBin(with: person)
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				XCTAssertEqual(creation.resource, person)
				XCTAssertEqual(creation.metadata.id, "<BIN_ID>")
				XCTAssertEqual(creation.metadata.isPrivate, true)
				XCTAssertEqual(creation.metadata.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertNil(creation.metadata.name)
				XCTAssertNil(creation.metadata.collectionID)
			default:
				XCTFail()
			}
		}

		func testCreatePrivateBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let person = Person(name: "Vaibhav", age: 30)
			let request = api.createBin(with: person, private: true)
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				XCTAssertEqual(creation.resource, person)
				XCTAssertEqual(creation.metadata.id, "<BIN_ID>")
				XCTAssertEqual(creation.metadata.isPrivate, true)
				XCTAssertEqual(creation.metadata.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertNil(creation.metadata.name)
				XCTAssertNil(creation.metadata.collectionID)
			default:
				XCTFail()
			}
		}

		func testCreatePublicBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let person = Person(name: "Vaibhav", age: 30)
			let request = api.createBin(with: person, private: false)
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				XCTAssertEqual(creation.resource, person)
				XCTAssertEqual(creation.metadata.id, "<BIN_ID>")
				XCTAssertEqual(creation.metadata.isPrivate, false)
				XCTAssertEqual(creation.metadata.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertNil(creation.metadata.name)
				XCTAssertNil(creation.metadata.collectionID)
			default:
				XCTFail()
			}
		}

		func testCreateNamedBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let name = "Vaibhav"
			let person = Person(name: name, age: 30)
			let request = api.createBin(named: name, with: person)
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				XCTAssertEqual(creation.resource, person)
				XCTAssertEqual(creation.metadata.id, "<BIN_ID>")
				XCTAssertEqual(creation.metadata.isPrivate, true)
				XCTAssertEqual(creation.metadata.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertEqual(creation.metadata.name, name)
				XCTAssertNil(creation.metadata.collectionID)
			default:
				XCTFail()
			}
		}

		func testCreateBinInCollection() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let person = Person(name: "Vaibhav", age: 30)
			let collectionID: Collection.ID = "<COLLECTION_ID>"
			let request = api.createBin(with: person, inCollectionWith: collectionID)
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				XCTAssertEqual(creation.resource, person)
				XCTAssertEqual(creation.metadata.id, "<BIN_ID>")
				XCTAssertEqual(creation.metadata.isPrivate, true)
				XCTAssertEqual(creation.metadata.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertNil(creation.metadata.name)
				XCTAssertEqual(creation.metadata.collectionID, collectionID)
			default:
				XCTFail()
			}
		}

		func testCreateValidBinInCollection() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let user = User(
				username: "vaibhav",
				password: nil,
				isLoggedIn: true,
				previousUsernames: ["_vaibhav", "vaibhav1"],
				highScore: 96.2
			)

			let collectionID: Collection.ID = "<USERS_COLLECTION_ID>"
			let request = api.createBin(with: user, inCollectionWith: collectionID)
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				XCTAssertEqual(creation.resource, user)
				XCTAssertEqual(creation.metadata.id, "<BIN_ID>")
				XCTAssertEqual(creation.metadata.isPrivate, true)
				XCTAssertEqual(creation.metadata.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertNil(creation.metadata.name)
				XCTAssertEqual(creation.metadata.collectionID, collectionID)
			default:
				XCTFail()
			}
		}

		func testCreateInvalidBinInCollection() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let person = Person(name: "Vaibhav", age: 30)
			let collectionID: Collection.ID = "<USERS_COLLECTION_ID>"
			let request = api.createBin(with: person, inCollectionWith: collectionID)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.badRequest, error)):
				XCTAssertEqual(error.message, "Schema Doc Validation Mismatch:  Should have required property 'username'")
				XCTAssertEqual(error.schemaDocID, "<SCHEMA_DOC_ID>")
				XCTAssertEqual(error.schemaDocName, "User")
			default:
				XCTFail()
			}
		}

		func testCreateBinEmpty() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let request = api.createBin(with: Empty())
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.badRequest, error)):
				XCTAssertEqual(error.message, "Bin cannot be blank")
			default:
				XCTFail()
			}
		}

		func testCreateBinInvalidCollectionID() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let person = Person(name: "Vaibhav", age: 30)
			let id: Collection.ID = "<INVALID_COLLECTION_ID>"
			let request = api.createBin(with: person, inCollectionWith: id)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.badRequest, error)):
				XCTAssertEqual(error.message, "Invalid Collection Id provided")
			default:
				XCTFail()
			}
		}

		func testCreateBinNameTooLong() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let person = Person(name: "Vaibhav", age: 30)
			let request = api.createBin(named: "Vvvvvvvvvvvvvvvaaaaaaaaaaaaaaaaaiiiiiiiiiiiiiiiiiiiiibbbbbbbbbbbbbbbbbbbbhhhhhhhhhhhhhhhhhhhaaaaaaaaaaaaaaaaaaaaavvvvvvvvvvvvvvvv", with: person)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.badRequest, error)):
				XCTAssertEqual(error.message, "X-Bin-Name cannot be blank or over 128 characters")
			default:
				XCTFail()
			}
		}

		func testCreateBinUnauthenticated() async {
			let api = JSONBin.V3.API()
			let person = Person(name: "Vaibhav", age: 30)
			let request = api.createBin(with: person)
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
			default:
				XCTFail()
			}
		}

		func testCreateBinInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let person = Person(name: "Vaibhav", age: 30)
			let request = api.createBin(with: person)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
			default:
				XCTFail()
			}
		}

		func testReadPrivateBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<PRIVATE_BIN_ID>"
			let request = api.readBin(with: id, of: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .success(read):
				let person = read.resource
				let metadata = read.metadata

				XCTAssertEqual(person.name, "Vaibhav")
				XCTAssertEqual(person.age, 30)
				XCTAssertEqual(metadata?.id, id)
				XCTAssertEqual(metadata?.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertEqual(metadata?.isPrivate, true)
				XCTAssertNil(metadata?.collectionID)
			default:
				print(result)
				XCTFail()
			}
		}

		func testReadPublicBin() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<PUBLIC_BIN_ID>"
			let request = api.readBin(with: id, of: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .success(read):
				let person = read.resource
				let metadata = read.metadata

				XCTAssertEqual(person.name, "Vaibhav")
				XCTAssertEqual(person.age, 30)
				XCTAssertEqual(metadata?.id, id)
				XCTAssertEqual(metadata?.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertEqual(metadata?.isPrivate, false)
				XCTAssertNil(metadata?.collectionID)
			default:
				XCTFail()
			}
		}

		func testReadBinWithoutMetadata() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.readBin(with: id, of: Person.self, includingMetadata: false)
			let result = await request.returnedResult

			switch result {
			case let .success(read):
				let person = read.resource
				let metadata = read.metadata

				XCTAssertEqual(person.name, "Vaibhav")
				XCTAssertEqual(person.age, 30)
				XCTAssertNil(metadata)
			default:
				XCTFail()
			}
		}

		func testReadBinInCollection() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<COLLECTION_BIN_ID>"
			let request = api.readBin(with: id, of: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .success(read):
				let person = read.resource
				let metadata = read.metadata

				XCTAssertEqual(person.name, "Vaibhav")
				XCTAssertEqual(person.age, 30)
				XCTAssertEqual(metadata?.id, id)
				XCTAssertEqual(metadata?.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertEqual(metadata?.isPrivate, true)
				XCTAssertEqual(metadata?.collectionID, "<COLLECTION_ID>")
			default:
				XCTFail()
			}
		}

		func testReadBinDotPath() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.readBin(with: id, of: String.self, usingDotPath: "name")
			let result = await request.returnedResult

			switch result {
			case let .success(read):
				let name = read.resource
				let metadata = read.metadata

				XCTAssertEqual(name, "Vaibhav")
				XCTAssertEqual(metadata?.id, id)
				XCTAssertEqual(metadata?.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertEqual(metadata?.isPrivate, true)
				XCTAssertNil(metadata?.collectionID)
			default:
				XCTFail()
			}
		}

		func testReadBinDotPathWithoutMetadata() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.readBin(with: id, of: String.self, includingMetadata: false, usingDotPath: "name")
			let result = await request.returnedResult

			switch result {
			case let .success(read):
				let name = read.resource
				let metadata = read.metadata

				XCTAssertEqual(name, "Vaibhav")
				XCTAssertNil(metadata)
			default:
				XCTFail()
			}
		}

		func testReadBinVersion() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.readBin(with: id, of: Person.self, at: .number(1))
			let result = await request.returnedResult

			switch result {
			case let .success(read):
				let person = read.resource
				let metadata = read.metadata

				XCTAssertEqual(person.name, "Vaibhav")
				XCTAssertEqual(person.age, 31)
				XCTAssertEqual(metadata?.id, id)
				XCTAssertEqual(metadata?.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertEqual(metadata?.isPrivate, true)
				XCTAssertNil(metadata?.collectionID)
			default:
				XCTFail()
			}
		}

		func testReadBinLatestVersion() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.readBin(with: id, of: Person.self, at: .latest)
			let result = await request.returnedResult

			switch result {
			case let .success(read):
				let person = read.resource
				let metadata = read.metadata

				XCTAssertEqual(person.name, "Vaibhav")
				XCTAssertEqual(person.age, 32)
				XCTAssertEqual(metadata?.id, id)
				XCTAssertEqual(metadata?.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertEqual(metadata?.isPrivate, true)
				XCTAssertNil(metadata?.collectionID)
			default:
				XCTFail()
			}
		}

		func testReadBinWithInvalidID() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<INVALID_BIN_ID>"
			let request = api.readBin(with: id, of: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Record ID")
			default:
				XCTFail()
			}
		}

		func testReadPrivateBinUnauthenticated() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<PRIVATE_BIN_ID>"
			let request = api.readBin(with: id, of: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header to read a private bin")
			default:
				XCTFail()
			}
		}

		func testReadPrivateBinInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: Bin.ID = "<PRIVATE_BIN_ID>"
			let request = api.readBin(with: id, of: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "X-Master-Key is invalid or the bin does not belong to your account")
			default:
				XCTFail()
			}
		}

		func testReadMissingBin() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<MISSING_BIN_ID>"
			let request = api.readBin(with: id, of: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Bin not found or it doesn't belong to your account")
			default:
				XCTFail()
			}
		}

		func testReadMissingBinVersion() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<BIN_ID>"
			let request = api.readBin(with: id, of: Person.self, at: .number(2))
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Bin version not found")
			default:
				XCTFail()
			}
		}

		func testVersionCountPrivateBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<PRIVATE_BIN_ID>"
			let request = api.versionCount(ofBinWith: id)
			let result = await request.returnedResult.map(\.metadata)

			switch result {
			case let .success(metadata):
				XCTAssertEqual(metadata.id, id)
				XCTAssertEqual(metadata.versionCount, 3)
				XCTAssertEqual(metadata.isPrivate, true)
			default:
				XCTFail()
			}
		}

		func testVersionCountPublicBin() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<PUBLIC_BIN_ID>"
			let request = api.versionCount(ofBinWith: id)
			let result = await request.returnedResult.map(\.metadata)

			switch result {
			case let .success(metadata):
				XCTAssertEqual(metadata.id, id)
				XCTAssertEqual(metadata.versionCount, 5)
				XCTAssertEqual(metadata.isPrivate, false)
			default:
				XCTFail()
			}
		}

		func testVersionCountPrivateBinUnauthenticated() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<PRIVATE_BIN_ID>"
			let request = api.versionCount(ofBinWith: id)
			let result = await request.returnedResult.map(\.metadata)

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header to get version count for the private bin")
			default:
				XCTFail()
			}
		}

		func testVersionCountPrivateBinInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: Bin.ID = "<PRIVATE_BIN_ID>"
			let request = api.versionCount(ofBinWith: id)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "X-Master-Key is invalid or the bin does not belong to your account")
			default:
				XCTFail()
			}
		}

		func testVersionCountMissingBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<MISSING_BIN_ID>"
			let request = api.versionCount(ofBinWith: id)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Bin not found or it doesn't belong to your account")
			default:
				XCTFail()
			}
		}

		func testUpdatePrivateBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<PRIVATE_BIN_ID>"
			let person = Person(name: "Vaibhav", age: 31)
			let request = api.updateBin(with: id, using: person)
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				XCTAssertEqual(update.resource, person)
				XCTAssertEqual(update.metadata.parentID, id)
				XCTAssertEqual(update.metadata.isPrivate, true)
				XCTAssertEqual(update.metadata.version, .number(1))
			default:
				XCTFail()
			}
		}

		func testUpdatePublicBin() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<PUBLIC_BIN_ID>"
			let person = Person(name: "Vaibhav", age: 31)
			let request = api.updateBin(with: id, using: person)
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				XCTAssertEqual(update.resource, person)
				XCTAssertEqual(update.metadata.parentID, id)
				XCTAssertEqual(update.metadata.isPrivate, false)
				XCTAssertEqual(update.metadata.version, .number(1))
			default:
				XCTFail()
			}
		}

		func testUpdateBinVersioned() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let person = Person(name: "Vaibhav", age: 31)
			let request = api.updateBin(with: id, using: person, versioning: true)
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				XCTAssertEqual(update.resource, person)
				XCTAssertEqual(update.metadata.parentID, id)
				XCTAssertEqual(update.metadata.isPrivate, true)
				XCTAssertEqual(update.metadata.version, .number(1))
			default:
				print(result)
				XCTFail()
			}
		}

		func testUpdateBinUnversioned() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let person = Person(name: "Vaibhav", age: 31)
			let request = api.updateBin(with: id, using: person, versioning: false)
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				XCTAssertEqual(update.resource, person)
				XCTAssertEqual(update.metadata.parentID, id)
				XCTAssertEqual(update.metadata.isPrivate, true)
				XCTAssertNil(update.metadata.version)
			default:
				XCTFail()
			}
		}

		func testUpdateBinName() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let name = "Jordan"
			let request = api.updateName(ofBinWith: id, toName: name)
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				XCTAssertEqual(update.id, id)
				XCTAssertEqual(update.metadata.name, name)
			default:
				XCTFail()
			}
		}

		func testUpdateBinPrivacy() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.updatePrivacy(ofBinWith: id, toPrivate: false)
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				XCTAssertEqual(update.id, id)
				XCTAssertEqual(update.metadata.isPrivate, false)
			default:
				XCTFail()
			}
		}

		func testUpdateBinWithInvalidID() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<INVALID_BIN_ID>"
			let person = Person(name: "Vaibhav", age: 31)
			let request = api.updateBin(with: id, using: person)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Record ID")
			default:
				XCTFail()
			}
		}

		func testUpdateBinEmpty() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.updateBin(with: id, using: Empty())
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.badRequest, error)):
				XCTAssertEqual(error.message, "Bin cannot be blank")
			default:
				XCTFail()
			}
		}

		func testUpdateInvalidBinInCollection() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<USER_BIN_ID>"
			let person = Person(name: "Vaibhav", age: 31)
			let request = api.updateBin(with: id, using: person)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.badRequest, error)):
				XCTAssertEqual(error.message, "Schema Doc Validation Mismatch:  Should have required property 'username'")
				XCTAssertEqual(error.schemaDocID, "<SCHEMA_DOC_ID>")
				XCTAssertEqual(error.schemaDocName, "User")
			default:
				XCTFail()
			}
		}

		func testUpdatePrivateBinUnauthenticated() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<PRIVATE_BIN_ID>"
			let person = Person(name: "Vaibhav", age: 31)
			let request = api.updateBin(with: id, using: person)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header to update a private bin")
			default:
				XCTFail()
			}
		}

		func testUpdatePrivateBinInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: Bin.ID = "<PRIVATE_BIN_ID>"
			let person = Person(name: "Vaibhav", age: 31)
			let request = api.updateBin(with: id, using: person)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "X-Master-Key is invalid or the bin does not belong to your account")
			default:
				XCTFail()
			}
		}

		func testUpdateMissingBin() async {
			let person = Person(name: "Vaibhav", age: 31)
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<MISSING_BIN_ID>"
			let request = api.updateBin(with: id, using: person)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Bin not found or it doesn't belong to your account")
			default:
				XCTFail()
			}
		}

		func testDeleteBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.deleteBin(with: id)
			let result = await request.returnedResult

			switch result {
			case let .success(deletion):
				XCTAssertEqual(deletion.message, "Bin deleted successfully")
				XCTAssertEqual(deletion.metadata?.id, id)
				XCTAssertEqual(deletion.metadata?.versionDeletionCount, 2)
			default:
				XCTFail()
			}
		}

		func testDeleteBinInvalidID() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<INVALID_BIN_ID>"
			let request = api.deleteBin(with: id)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Record ID")
			default:
				XCTFail()
			}
		}

		func testDeleteBinUnauthenticated() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<BIN_ID>"
			let request = api.deleteBin(with: id)
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
			default:
				XCTFail()
			}
		}

		func testDeleteBinInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.deleteBin(with: id)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
			default:
				XCTFail()
			}
		}

		func testDeleteMissingBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<MISSING_BIN_ID>"
			let request = api.deleteBin(with: id)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Bin not found or it doesn't belong to your account")
			default:
				XCTFail()
			}
		}

		func testDeleteBinVersions() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.deleteVersions(ofBinWith: id)
			let result = await request.returnedResult

			switch result {
			case let .success(deletion):
				XCTAssertEqual(deletion.message, "Versions for the Bin are deleted successfully")
				XCTAssertEqual(deletion.metadata?.id, id)
				XCTAssertEqual(deletion.metadata?.versionDeletionCount, 3)
			default:
				XCTFail()
			}
		}

		func testDeleteBinVersionsPreservingLatest() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.deleteVersions(ofBinWith: id, preservingLatest: true)
			let result = await request.returnedResult

			switch result {
			case let .success(deletion):
				XCTAssertEqual(deletion.message, "Versions for the Bin are deleted successfully and latest version preserved on the base record.")
				XCTAssertEqual(deletion.metadata?.id, id)
				XCTAssertEqual(deletion.metadata?.versionDeletionCount, 2)
			default:
				XCTFail()
			}
		}

		func testDeleteBinVersionsNotPreservingLatest() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.deleteVersions(ofBinWith: id, preservingLatest: false)
			let result = await request.returnedResult

			switch result {
			case let .success(deletion):
				XCTAssertEqual(deletion.message, "Versions for the Bin are deleted successfully")
				XCTAssertEqual(deletion.metadata?.id, id)
				XCTAssertEqual(deletion.metadata?.versionDeletionCount, 3)
			default:
				XCTFail()
			}
		}

		func testDeleteBinVersionsNotFound() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<UNVERSIONED_BIN_ID>"
			let request = api.deleteVersions(ofBinWith: id)
			let result = await request.returnedResult

			switch result {
			case let .success(deletion):
				XCTAssertEqual(deletion.message, "No versions found")
				XCTAssertNil(deletion.metadata)
			default:
				XCTFail()
			}
		}

		func testDeleteBinVersionsInvalidID() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<INVALID_BIN_ID>"
			let request = api.deleteVersions(ofBinWith: id)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Record ID")
			default:
				XCTFail()
			}
		}

		func testDeleteBinVersionsUnauthenticated() async {
			let api = JSONBin.V3.API()
			let id: Bin.ID = "<BIN_ID>"
			let request = api.deleteVersions(ofBinWith: id)
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
			default:
				XCTFail()
			}
		}

		func testDeleteBinVersionsInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: Bin.ID = "<BIN_ID>"
			let request = api.deleteVersions(ofBinWith: id)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
			default:
				XCTFail()
			}
		}

		func testDeleteVersionsOfMissingBin() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: Bin.ID = "<MISSING_BIN_ID>"
			let request = api.deleteVersions(ofBinWith: id)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Bin not found or it doesn't belong to your account")
			default:
				XCTFail()
			}
		}
	}
#endif
