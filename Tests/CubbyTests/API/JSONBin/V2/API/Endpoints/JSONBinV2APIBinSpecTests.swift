// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Cubby

#if swift(>=5.5)
@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
final class JSONBinV2APIBinSpecTests: XCTestCase {
	func testCreateBin() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let person = Person(name: "Vaibhav", age: 30)
		let request = api.createBin(with: person)
		let result = await request.returnedResult

		switch result {
		case let .success(creation):
			XCTAssertEqual(creation.success, true)
			XCTAssertEqual(creation.resource, person)
			XCTAssertEqual(creation.id, "<BIN_ID>")
			XCTAssertEqual(creation.isPrivate, true)
			XCTAssertNil(creation.name)
			XCTAssertNil(creation.collectionID)
		default:
			XCTFail()
		}
	}

	func testCreatePrivateBin() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let person = Person(name: "Vaibhav", age: 30)
		let request = api.createBin(with: person, private: true)
		let result = await request.returnedResult

		switch result {
		case let .success(creation):
			XCTAssertEqual(creation.success, true)
			XCTAssertEqual(creation.resource, person)
			XCTAssertEqual(creation.id, "<BIN_ID>")
			XCTAssertEqual(creation.isPrivate, true)
			XCTAssertNil(creation.name)
			XCTAssertNil(creation.collectionID)
		default:
			XCTFail()
		}
	}

	func testCreatePublicBin() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let person = Person(name: "Vaibhav", age: 30)
		let request = api.createBin(with: person, private: false)
		let result = await request.returnedResult

		switch result {
		case let .success(creation):
			XCTAssertEqual(creation.success, true)
			XCTAssertEqual(creation.resource, person)
			XCTAssertEqual(creation.id, "<BIN_ID>")
			XCTAssertEqual(creation.isPrivate, false)
			XCTAssertNil(creation.name)
			XCTAssertNil(creation.collectionID)
		default:
			XCTFail()
		}
	}

	func testCreateNamedBin() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let name = "Vaibhav"
		let person = Person(name: name, age: 30)
		let request = api.createBin(named: name, with: person)
		let result = await request.returnedResult

		switch result {
		case let .success(creation):
			XCTAssertEqual(creation.success, true)
			XCTAssertEqual(creation.resource, person)
			XCTAssertEqual(creation.id, "<BIN_ID>")
			XCTAssertEqual(creation.isPrivate, true)
			XCTAssertEqual(creation.name, name)
			XCTAssertNil(creation.collectionID)
		default:
			XCTFail()
		}
	}

	func testCreateBinInCollection() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let person = Person(name: "Vaibhav", age: 30)
		let collectionID: Collection.ID = "<COLLECTION_ID>"
		let request = api.createBin(with: person, inCollectionWith: collectionID)
		let result = await request.returnedResult

		switch result {
		case let .success(creation):
			XCTAssertEqual(creation.success, true)
			XCTAssertEqual(creation.resource, person)
			XCTAssertEqual(creation.id, "<BIN_ID>")
			XCTAssertEqual(creation.isPrivate, true)
			XCTAssertNil(creation.name)
			XCTAssertEqual(creation.collectionID, collectionID)
		default:
			XCTFail()
		}
	}

	func testCreateValidBinInCollection() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
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
			XCTAssertEqual(creation.success, true)
			XCTAssertEqual(creation.resource, user)
			XCTAssertEqual(creation.id, "<USER_BIN_ID>")
			XCTAssertEqual(creation.isPrivate, true)
			XCTAssertNil(creation.name)
			XCTAssertEqual(creation.collectionID, collectionID)
		default:
			XCTFail()
		}
	}

	func testCreateInvalidBinInCollection() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let person = Person(name: "Vaibhav", age: 30)
		let collectionID: Collection.ID = "<USERS_COLLECTION_ID>"
		let request = api.createBin(with: person, inCollectionWith: collectionID)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Schema Doc Validation Mismatch:  Should have required property 'username'")
			XCTAssertEqual(error.success, false)
			XCTAssertEqual(error.schemaDocID, "<SCHEMA_DOC_ID>")
			XCTAssertEqual(error.schemaDocName, "User")
		default:
			XCTFail()
		}
	}

	func testCreateBinUnauthenticated() async {
		let api = JSONBin.V2.API()
		let person = Person(name: "Vaibhav", age: 30)
		let request = api.createBin(with: person)
		let result = await request.returnedResult

		switch result {
		case .failure(.requestUnsuccessful(.unauthorized, let error)):
			XCTAssertEqual(error.message, "You need to pass a secret-key in the header to Create a Bin")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testCreateBinEmpty() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let request = api.createBin(with: Empty())
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
			XCTAssertEqual(error.message, "JSON cannot be empty")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testCreateBinInvalidCollectionID() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let person = Person(name: "Vaibhav", age: 30)
		let id: Collection.ID = "<INVALID_COLLECTION_ID>"
		let request = api.createBin(with: person, inCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
			XCTAssertEqual(error.message, "Invalid Collection ID")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testCreateBinInavalidAuthorization() async {
		let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
		let person = Person(name: "Vaibhav", age: 30)
		let request = api.createBin(with: person)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid secret key provided.")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testCreateBinNameTooLong() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let person = Person(name: "Vaibhav", age: 30)
		let request = api.createBin(named: "Vvvvvvvvvvvvvvvaaaaaaaaaaaaaaaaaiiiiiiiiiiiiiiiiiiiiibbbbbbbbbbbbbbbbbbbbhhhhhhhhhhhhhhhhhhhaaaaaaaaaaaaaaaaaaaaavvvvvvvvvvvvvvvv", with: person)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
			XCTAssertEqual(error.message, "Bin Name cannot be longer than 128 characters.")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testReadPublicBin() async {
		let api = JSONBin.V2.API()
		let id: Bin.ID = "<PUBLIC_BIN_ID>"
		let request = api.readBin(with: id, of: Person.self)
		let result = await request.returnedResult

		switch result {
		case let .success(person):
			XCTAssertEqual(person.name, "Vaibhav")
			XCTAssertEqual(person.age, 30)
		default:
			XCTFail()
		}
	}

	func testReadPrivateBin() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<PRIVATE_BIN_ID>"
		let request = api.readBin(with: id, of: Person.self)
		let result = await request.returnedResult

		switch result {
		case let .success(person):
			XCTAssertEqual(person.name, "Vaibhav")
			XCTAssertEqual(person.age, 30)
		default:
			XCTFail()
		}
	}

	func testReadBinVersion() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<BIN_ID>"
		let request = api.readBin(with: id, of: Person.self, at: .number(1))
		let result = await request.returnedResult

		switch result {
		case let .success(person):
			XCTAssertEqual(person.name, "Vaibhav")
			XCTAssertEqual(person.age, 31)
		default:
			XCTFail()
		}
	}

	func testReadBinLatestVersion() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<BIN_ID>"
		let request = api.readBin(with: id, of: Person.self, at: .latest)
		let result = await request.returnedResult

		switch result {
		case let .success(person):
			XCTAssertEqual(person.name, "Vaibhav")
			XCTAssertEqual(person.age, 32)
		default:
			XCTFail()
		}
	}

	func testReadPrivateBinUnauthenticated() async {
		let api = JSONBin.V2.API()
		let id: Bin.ID = "<PRIVATE_BIN_ID>"
		let request = api.readBin(with: id, of: Person.self)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Need to provide a secret-key to READ private bins")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testReadPrivateBinInvalidAuthorization() async {
		let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
		let id: Bin.ID = "<PRIVATE_BIN_ID>"
		let request = api.readBin(with: id, of: Person.self)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid secret key provided.")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testReadMissingBin() async {
		let api = JSONBin.V2.API()
		let id: Bin.ID = "<MISSING_BIN_ID>"
		let request = api.readBin(with: id, of: Person.self)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.notFound, error)):
			XCTAssertEqual(error.message, "Bin not found")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testReadMissingBinVersion() async {
		let api = JSONBin.V2.API()
		let id: Bin.ID = "<BIN_ID>"
		let request = api.readBin(with: id, of: Person.self, at: .number(2))
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.notFound, error)):
			XCTAssertEqual(error.message, "Bin version not found")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testReadBinWithInvalidID() async {
		let api = JSONBin.V2.API()
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

	func testUpdatePrivateBin() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<PRIVATE_BIN_ID>"
		let person = Person(name: "Vaibhav", age: 31)
		let request = api.updateBin(with: id, using: person)
		let result = await request.returnedResult

		switch result {
		case let .success(update):
			XCTAssertEqual(update.success, true)
			XCTAssertEqual(update.resource, person)
			XCTAssertEqual(update.parentID, id)
			XCTAssertEqual(update.version, .number(1))
		default:
			XCTFail()
		}
	}

	func testUpdatePublicBin() async {
		let person = Person(name: "Vaibhav", age: 31)
		let api = JSONBin.V2.API()
		let id: Bin.ID = "<PUBLIC_BIN_ID>"
		let request = api.updateBin(with: id, using: person)
		let result = await request.returnedResult

		switch result {
		case let .success(update):
			XCTAssertEqual(update.success, true)
			XCTAssertEqual(update.resource, person)
			XCTAssertEqual(update.version, .number(1))
			XCTAssertEqual(update.parentID, id)
		default:
			XCTFail()
		}
	}

	func testUpdateBinVersioned() async {
		let person = Person(name: "Vaibhav", age: 31)
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<BIN_ID>"
		let request = api.updateBin(with: id, using: person, versioning: true)
		let result = await request.returnedResult

		switch result {
		case let .success(update):
			XCTAssertEqual(update.success, true)
			XCTAssertEqual(update.resource, person)
			XCTAssertEqual(update.version, .number(1))
			XCTAssertEqual(update.parentID, id)
		default:
			XCTFail()
		}
	}

	func testUpdateBinUnversioned() async {
		let person = Person(name: "Vaibhav", age: 31)
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<BIN_ID>"
		let request = api.updateBin(with: id, using: person, versioning: false)
		let result = await request.returnedResult

		switch result {
		case let .success(update):
			XCTAssertEqual(update.success, true)
			XCTAssertEqual(update.resource, person)
			XCTAssertNil(update.version)
			XCTAssertEqual(update.parentID, id)
		default:
			XCTFail()
		}
	}

	func testUpdateInvalidBinInCollection() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<USER_BIN_ID>"
		let person = Person(name: "Vaibhav", age: 31)
		let request = api.updateBin(with: id, using: person)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Schema Doc Validation Mismatch:  Should have required property 'username'")
			XCTAssertEqual(error.schemaDocName, "User")
			XCTAssertEqual(error.schemaDocID, "<SCHEMA_DOC_ID>")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testUpdatePrivateBinUnauthenticated() async {
		let person = Person(name: "Vaibhav", age: 31)
		let api = JSONBin.V2.API()
		let id: Bin.ID = "<PRIVATE_BIN_ID>"
		let request = api.updateBin(with: id, using: person)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Need to provide a secret-key to UPDATE private bins")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testUpdatePrivateBinInvalidAuthorization() async {
		let person = Person(name: "Vaibhav", age: 31)
		let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
		let id: Bin.ID = "<PRIVATE_BIN_ID>"
		let request = api.updateBin(with: id, using: person)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid secret key provided.")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testUpdateMissingBin() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<MISSING_BIN_ID>"
		let person = Person(name: "Vaibhav", age: 31)
		let request = api.updateBin(with: id, using: person)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.notFound, error)):
			XCTAssertEqual(error.message, "Bin not found")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testUpdateBinWithInvalidID() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
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
		let empty = Empty()
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<BIN_ID>"
		let request = api.updateBin(with: id, using: empty)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
			XCTAssertEqual(error.message, "JSON cannot be empty")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testDeleteBin() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<BIN_ID>"
		let request = api.deleteBin(with: id)
		let result = await request.returnedResult

		switch result {
		case let .success(deletion):
			XCTAssertEqual(deletion.success, true)
			XCTAssertEqual(deletion.id, "<BIN_ID>")
			XCTAssertEqual(deletion.message, "Bin <BIN_ID> is deleted successfully. 2 versions removed.")
		default:
			XCTFail()
		}
	}

	func testDeleteBinUnauthenticated() async {
		let api = JSONBin.V2.API()
		let id: Bin.ID = "<BIN_ID>"
		let request = api.deleteBin(with: id)
		let result = await request.returnedResult

		switch result {
		case .failure(.requestUnsuccessful(.unauthorized, let error)):
			XCTAssertEqual(error.message, "Need to provide a secret-key to DELETE bins")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testDeleteBinInvalidID() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
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

	func testDeleteBinInvalidAuthorization() async {
		let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
		let id: Bin.ID = "<BIN_ID>"
		let request = api.deleteBin(with: id)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid secret key provided.")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}

	func testDeleteMissingBin() async {
		let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
		let id: Bin.ID = "<MISSING_BIN_ID>"
		let request = api.deleteBin(with: id)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.notFound, error)):
			XCTAssertEqual(error.message, "Bin not found")
			XCTAssertEqual(error.success, false)
		default:
			XCTFail()
		}
	}
}
#endif
