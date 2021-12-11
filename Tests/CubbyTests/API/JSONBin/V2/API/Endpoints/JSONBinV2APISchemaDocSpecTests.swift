// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Cubby

#if swift(>=5.5)
	@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	final class JSONBinV2APISchemaDocSpecTests: XCTestCase {
		func testCreateSchemaDoc() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let request = api.createSchemaDoc(for: Person.self, named: "Person")
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				XCTAssertEqual(creation.success, true)
				XCTAssertEqual(creation.id, "<SCHEMA_DOC_ID>")
				XCTAssertEqual(creation.data.id, "http://example.com/person.schema.json")
				XCTAssertEqual(creation.data.schemaURI, "http://json-schema.org/draft-07/schema#")
				XCTAssertEqual(creation.data.title, "Person")
				XCTAssertEqual(creation.data.description, "A person object.")
				XCTAssertEqual(creation.data.type, .object)
				XCTAssertEqual(
					creation.data.properties, [
						.name: .string,
						.nickname: .optional(.string),
						.age: .integer
					]
				)
			default:
				XCTFail()
			}
		}

		func testCreateSchemaDocUnauthenticated() async {
			let api = JSONBin.V2.API()
			let request = api.createSchemaDoc(for: Person.self, named: "Person")
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "Need to provide a secret-key to CREATE a Schema")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testCreateSchemaDocInvalidAuthorization() async {
			let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
			let request = api.createSchemaDoc(for: Person.self, named: "Person")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid secret key provided.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testCreateSchemaDocNameEmpty() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let request = api.createSchemaDoc(for: Person.self, named: "")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "You need to provide a name for the Schema Document")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testCreateSchemaDocNameInvalidLength() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let request = api.createSchemaDoc(for: Person.self, named: "P")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Schema Doc Name length should be more than 2 characters and less than 33 characters")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testReadSchemaDoc() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .success(schemaDoc):
				XCTAssertEqual(schemaDoc.id, "http://example.com/person.schema.json")
				XCTAssertEqual(schemaDoc.schemaURI, "http://json-schema.org/draft-07/schema#")
				XCTAssertEqual(schemaDoc.title, "Person")
				XCTAssertEqual(schemaDoc.description, "A person object.")
				XCTAssertEqual(schemaDoc.type, .object)
				XCTAssertEqual(
					schemaDoc.properties, [
						.name: .string,
						.nickname: .optional(.string),
						.age: .integer
					]
				)
			default:
				XCTFail()
			}
		}

		func testReadSchemaDocUnauthenticated() async {
			let api = JSONBin.V2.API()
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Need to provide a secret-key to READ Schema Document.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testReadSchemaDocInvalidAuthorization() async {
			let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid secret key provided.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testReadMissingSchemaDoc() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<MISSING_SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Schema Document not found")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testReadSchemaDocWithInvalidID() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<INVALID_SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Schema Document ID")
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDoc() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				XCTAssertEqual(creation.success, true)
				XCTAssertEqual(creation.id, id)
				XCTAssertNil(creation.data.id)
				XCTAssertNil(creation.data.schemaURI)
				XCTAssertEqual(creation.data.title, "User")
				XCTAssertNil(creation.data.description)
				XCTAssertEqual(creation.data.type, .object)
				XCTAssertEqual(
					creation.data.properties, [
						.username: .string,
						.password: .null,
						.isLoggedIn: .boolean,
						.previousUsernames: .array,
						.highScore: .number
					]
				)
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDocUnauthenticated() async {
			let api = JSONBin.V2.API()
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "Need to provide a secret-key to UPDATE Schema Doc")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDocInvalidAuthorization() async {
			let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid secret key provided.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateMissingSchemaDoc() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<MISSING_SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Schema Document not found")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDocWithInvalidID() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<INVALID_SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Schema Document ID")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}
	}
#endif
