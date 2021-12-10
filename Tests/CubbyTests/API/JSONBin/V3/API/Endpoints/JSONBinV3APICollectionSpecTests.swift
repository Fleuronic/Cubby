// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Cubby

@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
final class JSONBinV3APICollectionSpecTests: XCTestCase {
	func testCreateCollection() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let name = "People"
		let request = api.createCollection(named: name)
		let result = await request.returnedResult

		switch result {
		case let .success(creation):
			XCTAssertEqual(creation.id, "<COLLECTION_ID>")
			XCTAssertEqual(creation.metadata.name, name)
		default:
			XCTFail()
		}
	}

	func testCreateCollectionUnauthenticated() async {
		let api = JSONBin.V3.API()
		let request = api.createCollection(named: "People")
		let result = await request.returnedResult

		switch result {
		case .failure(.requestUnsuccessful(.unauthorized, let error)):
			XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
		default:
			XCTFail()
		}
	}

	func testCreateCollectionInvalidAuthorization() async {
		let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
		let request = api.createCollection(named: "People")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
		default:
			XCTFail()
		}
	}

	func testCreateCollectionNameEmpty() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let request = api.createCollection(named: "")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.badRequest, error)):
			XCTAssertEqual(error.message, "You need to pass X-Collection-Name header to set a name for the Collection")
		default:
			XCTFail()
		}
	}

	func testCreateCollectionNameInvalidLength() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let request = api.createCollection(named: "Ppppeeeoooooooppppppppllllllllleeeeee")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.badRequest, error)):
			XCTAssertEqual(error.message, "Name of the Collection cannot be above 32 characters")
		default:
			XCTFail()
		}
	}

	func testFetchBinsInCollection() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<USERS_COLLECTION_ID>"
		let request = api.fetchBins(inCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case let .success(results):
			let user1Result = results[0]
			let user2Result = results[1]

			XCTAssertEqual(user1Result.id, "<BIN_2_ID>")
			XCTAssertEqual(user1Result.isPrivate, true)
			XCTAssertEqual(user1Result.creationDate, .init(timeIntervalSince1970: 0))
			XCTAssertEqual(user1Result.metadata.name, "User 2")

			XCTAssertEqual(user2Result.id, "<BIN_1_ID>")
			XCTAssertEqual(user2Result.isPrivate, true)
			XCTAssertEqual(user2Result.creationDate, .init(timeIntervalSince1970: 0))
			XCTAssertEqual(user2Result.metadata.name, "User 1")
		default:
			XCTFail()
		}
	}

	func testFetchBinsInCollectionSorted() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<USERS_COLLECTION_ID>"
		let request = api.fetchBins(inCollectionWith: id, sortedBy: .ascending)
		let result = await request.returnedResult

		switch result {
		case let .success(results):
			let user1Result = results[0]
			let user2Result = results[1]

			XCTAssertEqual(user1Result.id, "<BIN_1_ID>")
			XCTAssertEqual(user1Result.isPrivate, true)
			XCTAssertEqual(user1Result.creationDate, .init(timeIntervalSince1970: 0))
			XCTAssertEqual(user1Result.metadata.name, "User 1")

			XCTAssertEqual(user2Result.id, "<BIN_2_ID>")
			XCTAssertEqual(user2Result.isPrivate, true)
			XCTAssertEqual(user2Result.creationDate, .init(timeIntervalSince1970: 0))
			XCTAssertEqual(user2Result.metadata.name, "User 2")
		default:
			XCTFail()
		}
	}

	func testFetchUncategorizedBins() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let request = api.fetchUncategorizedBins()
		let result = await request.returnedResult

		switch result {
		case let .success(results):
			let user1Result = results[0]
			let user2Result = results[1]

			XCTAssertEqual(user1Result.id, "<BIN_2_ID>")
			XCTAssertEqual(user1Result.isPrivate, true)
			XCTAssertEqual(user1Result.creationDate, .init(timeIntervalSince1970: 0))
			XCTAssertEqual(user1Result.metadata.name, "User")

			XCTAssertEqual(user2Result.id, "<BIN_1_ID>")
			XCTAssertEqual(user2Result.isPrivate, true)
			XCTAssertEqual(user2Result.creationDate, .init(timeIntervalSince1970: 0))
			XCTAssertEqual(user2Result.metadata.name, "Person")
		default:
			XCTFail()
		}
	}

	func testFetchUncategorizedBinsSorted() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let request = api.fetchUncategorizedBins(sortedBy: .ascending)
		let result = await request.returnedResult

		switch result {
		case let .success(results):
			let user1Result = results[0]
			let user2Result = results[1]

			XCTAssertEqual(user1Result.id, "<BIN_1_ID>")
			XCTAssertEqual(user1Result.isPrivate, true)
			XCTAssertEqual(user1Result.creationDate, .init(timeIntervalSince1970: 0))
			XCTAssertEqual(user1Result.metadata.name, "Person")

			XCTAssertEqual(user2Result.id, "<BIN_2_ID>")
			XCTAssertEqual(user2Result.isPrivate, true)
			XCTAssertEqual(user2Result.creationDate, .init(timeIntervalSince1970: 0))
			XCTAssertEqual(user2Result.metadata.name, "User")
		default:
			XCTFail()
		}
	}

	func testFetchBinsInCollectionUnauthenticated() async {
		let api = JSONBin.V3.API()
		let id: Collection.ID = "<COLLECTION_ID>"
		let request = api.fetchBins(inCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case .failure(.requestUnsuccessful(.unauthorized, let error)):
			XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
		default:
			XCTFail()
		}
	}

	func testFetchBinsInCollectionInvalidAuthorization() async {
		let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
		let id: Collection.ID = "<COLLECTION_ID>"
		let request = api.fetchBins(inCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
		default:
			XCTFail()
		}
	}

	func testFetchUncategorizedBinsUnauthenticated() async {
		let api = JSONBin.V3.API()
		let request = api.fetchUncategorizedBins()
		let result = await request.returnedResult

		switch result {
		case .failure(.requestUnsuccessful(.unauthorized, let error)):
			XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
		default:
			XCTFail()
		}
	}

	func testFetchUncategorizedBinsInvalidAuthorization() async {
		let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
		let request = api.fetchUncategorizedBins()
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
		default:
			XCTFail()
		}
	}

	func testUpdateCollectionName() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<COLLECTION_ID>"
		let name = "Persons"
		let request = api.updateName(ofCollectionWith: id, toName: name)
		let result = await request.returnedResult

		switch result {
		case let .success(update):
			XCTAssertEqual(update.id, id)
			XCTAssertEqual(update.metadata.name, name)
		default:
			XCTFail()
		}
	}

	func testAddCollectionSchemaDoc() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<USERS_COLLECTION_ID>"
		let schemaDocID: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
		let request = api.addSchemaDoc(with: schemaDocID, toCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case let .success(update):
			XCTAssertEqual(update.id, schemaDocID)
			XCTAssertEqual(update.collectionName, "Users")
			XCTAssertEqual(update.metadata.id, id)
			XCTAssertEqual(update.metadata.creationDate, .init(timeIntervalSince1970: 0))
		default:
			XCTFail()
		}
	}

	func testRemoveCollectionSchemaDoc() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<USERS_COLLECTION_ID>"
		let request = api.removeSchemaDoc(fromCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case let .success(removal):
			XCTAssertEqual(removal.collectionName, "Users")
			XCTAssertEqual(removal.metadata.id, id)
			XCTAssertEqual(removal.metadata.creationDate, .init(timeIntervalSince1970: 0))
		default:
			XCTFail()
		}
	}

	func testUpdateCollectionNameUnauthenticated() async {
		let api = JSONBin.V3.API()
		let id: Collection.ID = "<COLLECTION_ID>"
		let request = api.updateName(ofCollectionWith: id, toName: "Persons")
		let result = await request.returnedResult

		switch result {
		case .failure(.requestUnsuccessful(.unauthorized, let error)):
			XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
		default:
			XCTFail()
		}
	}

	func testUpdateCollectionInvalidAuthorization() async {
		let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
		let id: Collection.ID = "<COLLECTION_ID>"
		let request = api.updateName(ofCollectionWith: id, toName: "Persons")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
		default:
			XCTFail()
		}
	}

	func testAddCollectionMissingSchemaDoc() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<USERS_COLLECTION_ID>"
		let schemaDocID: SchemaDoc.ID = "<MISSING_SCHEMA_DOC_ID>"
		let request = api.addSchemaDoc(with: schemaDocID, toCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.notFound, error)):
			XCTAssertEqual(error.message, "Schema Doc not found")
		default:
			XCTFail()
		}
	}

	func testUpdateMissingCollectionName() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<MISSING_COLLECTION_ID>"
		let request = api.updateName(ofCollectionWith: id, toName: "Persons")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.notFound, error)):
			XCTAssertEqual(error.message, "Collection not found")
		default:
			XCTFail()
		}
	}

	func testAddMissingCollectionSchemaDoc() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<MISSING_COLLECTION_ID>"
		let schemaDocID: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
		let request = api.addSchemaDoc(with: schemaDocID, toCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.notFound, error)):
			XCTAssertEqual(error.message, "Collection not found")
		default:
			XCTFail()
		}
	}

	func testRemoveMissingCollectionSchemaDoc() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<MISSING_COLLECTION_ID>"
		let request = api.removeSchemaDoc(fromCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.notFound, error)):
			XCTAssertEqual(error.message, "Collection not found")
		default:
			XCTFail()
		}
	}

	func testUpdateCollectionNameInvalidID() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<INVALID_COLLECTION_ID>"
		let request = api.updateName(ofCollectionWith: id, toName: "Persons")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.badRequest, error)):
			XCTAssertEqual(error.message, "Invalid Collection Id provided")
		default:
			XCTFail()
		}
	}

	func testAddCollectionInvalidSchemaDocID() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<USERS_COLLECTION_ID>"
		let schemaDocID: SchemaDoc.ID = "<INVALID_SCHEMA_DOC_ID>"
		let request = api.addSchemaDoc(with: schemaDocID, toCollectionWith: id)
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
			XCTAssertEqual(error.message, "Invalid Schema Id provided")
		default:
			XCTFail()
		}
	}

	func testUpdateCollectionNameEmpty() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<COLLECTION_ID>"
		let request = api.updateName(ofCollectionWith: id, toName: "")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.badRequest, error)):
			XCTAssertEqual(error.message, "You need to pass X-Collection-Name header to set a name for the Collection")
		default:
			XCTFail()
		}
	}

	func testUpdateCollectionNameInvalidLength() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let id: Collection.ID = "<COLLECTION_ID>"
		let request = api.updateName(ofCollectionWith: id, toName: "Ppppeeeoooooooppppppppllllllllleeeeee")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.badRequest, error)):
			XCTAssertEqual(error.message, "Name of the Collection cannot be above 32 characters")
		default:
			XCTFail()
		}
	}
}
