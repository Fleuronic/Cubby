// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Cubby

#if swift(>=5.5)
	@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	final class JSONBinV2APICollectionSpecTests: XCTestCase {
		func testCreateCollection() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let name = "People"
			let request = api.createCollection(named: name)
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				XCTAssertEqual(creation.success, true)
				XCTAssertEqual(creation.id, "<COLLECTION_ID>")
				XCTAssertEqual(creation.details.name, name)
			default:
				XCTFail()
			}
		}

		func testCreateCollectionUnauthenticated() async {
			let api = JSONBin.V2.API()
			let request = api.createCollection(named: "People")
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "Need to provide a secret-key to CREATE a Collection.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testCreateCollectionInvalidAuthorization() async {
			let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
			let request = api.createCollection(named: "People")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid secret key provided.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testCreateCollectionNameEmpty() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let request = api.createCollection(named: "")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "You need to provide a name key.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testCreateCollectionNameInvalidLength() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let request = api.createCollection(named: "P")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Collection Name length should be more than 2 characters and less than 33 characters")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateCollectionName() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: Collection.ID = "<COLLECTION_ID>"
			let name = "Persons"
			let request = api.updateCollection(with: id, using: .updateName(name))
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				XCTAssertEqual(update.success, true)
				XCTAssertEqual(update.collectionID, id)
				XCTAssertEqual(update.collectionDetails?.name, name)
				XCTAssertNil(update.schemaDocID)
				XCTAssertNil(update.schemaDocDetails?.name)
			default:
				XCTFail()
			}
		}

		func testAddCollectionSchemaDoc() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: Collection.ID = "<USERS_COLLECTION_ID>"
			let schemaDocID: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.updateCollection(with: id, using: .addSchemaDoc(id: schemaDocID))
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				XCTAssertEqual(update.success, true)
				XCTAssertEqual(update.collectionID, id)
				XCTAssertEqual(update.collectionDetails?.name, "People")
				XCTAssertEqual(update.schemaDocID, schemaDocID)
				XCTAssertEqual(update.schemaDocDetails?.name, "Person")
			default:
				XCTFail()
			}
		}

		func testRemoveCollectionSchemaDoc() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: Collection.ID = "<USERS_COLLECTION_ID>"
			let request = api.updateCollection(with: id, using: .removeSchemaDoc)
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				XCTAssertEqual(update.success, true)
				XCTAssertNil(update.collectionID)
				XCTAssertNil(update.collectionDetails?.name)
				XCTAssertNil(update.schemaDocID)
				XCTAssertNil(update.schemaDocDetails?.name)
			default:
				XCTFail()
			}
		}

		func testUpdateCollectionUnauthenticated() async {
			let api = JSONBin.V2.API()
			let id: Collection.ID = "<COLLECTION_ID>"
			let request = api.updateCollection(with: id, using: .updateName("Persons"))
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "Need to provide a secret-key to UPDATE Collections")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateCollectionInvalidAuthorization() async {
			let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: Collection.ID = "<COLLECTION_ID>"
			let request = api.updateCollection(with: id, using: .updateName("Persons"))
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid secret key provided.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateCollectionMissingSchemaDoc() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: Collection.ID = "<USERS_COLLECTION_ID>"
			let schemaDocID: SchemaDoc.ID = "<MISSING_SCHEMA_DOC_ID>"
			let request = api.updateCollection(with: id, using: .addSchemaDoc(id: schemaDocID))
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Schema Document not found")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateMissingCollection() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: Collection.ID = "<MISSING_COLLECTION_ID>"
			let request = api.updateCollection(with: id, using: .updateName("Persons"))
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Collection not found")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateCollectionInvalidID() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: Collection.ID = "<INVALID_COLLECTION_ID>"
			let request = api.updateCollection(with: id, using: .updateName("Persons"))
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Collection ID")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateCollectionInvalidSchemaDocID() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: Collection.ID = "<USERS_COLLECTION_ID>"
			let schemaDocID: SchemaDoc.ID = "<INVALID_SCHEMA_DOC_ID>"
			let request = api.updateCollection(with: id, using: .addSchemaDoc(id: schemaDocID))
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Schema Doc ID")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateCollectionNameEmpty() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: Collection.ID = "<USERS_COLLECTION_ID>"
			let request = api.updateCollection(with: id, using: .updateName(""))
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "You need to provide a name key.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateCollectionNameInvalidLength() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: Collection.ID = "<USERS_COLLECTION_ID>"
			let request = api.updateCollection(with: id, using: .updateName("P"))
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Collection Name length should be more than 2 characters and less than 33 characters")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}
	}
#endif
