// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Cubby

#if swift(>=5.5)
	#if swift(<5.5.2)
		@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	#endif
	final class JSONBinV3APISchemaDocSpecTests: XCTestCase {
		func testCreateSchemaDoc() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let request = api.createSchemaDoc(for: Person.self, named: "Person")
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				let schema = creation.schema
				let metadata = creation.metadata

				XCTAssertEqual(metadata.id, "<SCHEMA_DOC_ID>")
				XCTAssertEqual(metadata.name, "Person")
				XCTAssertEqual(metadata.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertEqual(schema.id, "http://example.com/person.schema.json")
				XCTAssertEqual(schema.schemaURI, "http://json-schema.org/draft-07/schema#")
				XCTAssertEqual(schema.title, "Person")
				XCTAssertEqual(schema.description, "A person object.")
				XCTAssertEqual(schema.type, .object)
				XCTAssertEqual(
					schema.properties, [
						.name: .string,
						.nickname: .optional(.string),
						.age: .integer
					]
				)
			default:
				XCTFail()
			}
		}

		func testCreateSchemaDocWithoutRequiredProperties() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let request = api.createSchemaDoc(for: Site.self, named: "Site")
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				let schema = creation.schema
				let metadata = creation.metadata

				XCTAssertEqual(metadata.id, "<SCHEMA_DOC_ID>")
				XCTAssertEqual(metadata.name, "Site")
				XCTAssertEqual(metadata.creationDate, .init(timeIntervalSince1970: 0))
				XCTAssertNil(schema.id)
				XCTAssertNil(schema.schemaURI)
				XCTAssertEqual(schema.title, "Site")
				XCTAssertNil(schema.description)
				XCTAssertEqual(schema.type, .object)
				XCTAssertEqual(
					schema.properties, [
						.httpURLString: .optional(.string),
						.httpsURLString: .optional(.string)
					]
				)
			default:
				XCTFail()
			}
		}

		func testCreateSchemaDocUnauthenticated() async {
			let api = JSONBin.V3.API()
			let request = api.createSchemaDoc(for: Person.self, named: "Person")
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
			default:
				XCTFail()
			}
		}

		func testCreateSchemaDocInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let request = api.createSchemaDoc(for: Person.self, named: "Person")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
			default:
				XCTFail()
			}
		}

		func testCreateSchemaDocNameEmpty() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let request = api.createSchemaDoc(for: Person.self, named: "")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.badRequest, error)):
				XCTAssertEqual(error.message, "You need to pass X-Schema-Doc-Name header to set a name for the Schema Doc")
			default:
				XCTFail()
			}
		}

		func testCreateSchemaDocNameInvalidLength() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let request = api.createSchemaDoc(for: Person.self, named: "Ppppeeerrrrrsssssssooooooonnnnnnn")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.badRequest, error)):
				XCTAssertEqual(error.message, "Name of the Schema Doc cannot be above 32 characters")
			default:
				XCTFail()
			}
		}

		func testReadSchemaDoc() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .success(read):
				let schema = read.schema
				let metadata = read.metadata

				XCTAssertEqual(metadata.id, id)
				XCTAssertEqual(schema.id, "http://example.com/person.schema.json")
				XCTAssertEqual(schema.schemaURI, "http://json-schema.org/draft-07/schema#")
				XCTAssertEqual(schema.title, "Person")
				XCTAssertEqual(schema.description, "A person object.")
				XCTAssertEqual(schema.type, .object)
				XCTAssertEqual(
					schema.properties, [
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
			let api = JSONBin.V3.API()
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
			default:
				XCTFail()
			}
		}

		func testReadSchemaDocInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
			default:
				XCTFail()
			}
		}

		func testReadMissingSchemaDoc() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<MISSING_SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Schema Doc not found")
			default:
				XCTFail()
			}
		}

		func testReadSchemaDocWithInvalidID() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<INVALID_SCHEMA_DOC_ID>"
			let request = api.readSchemaDoc(with: id, for: Person.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.badRequest, error)):
				XCTAssertEqual(error.message, "Invalid Schema Id provided")
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDoc() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case let .success(creation):
				let schema = creation.schema
				let metadata = creation.metadata

				XCTAssertEqual(metadata.id, id)
				XCTAssertNil(schema.id)
				XCTAssertNil(schema.schemaURI)
				XCTAssertEqual(schema.title, "User")
				XCTAssertNil(schema.description)
				XCTAssertEqual(schema.type, .object)
				XCTAssertEqual(
					schema.properties, [
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
			let api = JSONBin.V3.API()
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDocInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
			default:
				XCTFail()
			}
		}

		func testUpdateMissingSchemaDoc() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<MISSING_SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Schema Doc not found")
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDocWithInvalidID() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<INVALID_SCHEMA_DOC_ID>"
			let request = api.updateSchemaDoc(with: id, toSchemaFor: User.self)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Schema Id provided")
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDocName() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let name = "User Schema"
			let request = api.updateName(ofSchemaDocWith: id, toName: name)
			let result = await request.returnedResult

			switch result {
			case let .success(update):
				let metadata = update.metadata
				XCTAssertEqual(metadata.id, id)
				XCTAssertEqual(metadata.name, name)
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDocNameUnauthenticated() async {
			let api = JSONBin.V3.API()
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.updateName(ofSchemaDocWith: id, toName: "User Schema")
			let result = await request.returnedResult

			switch result {
			case .failure(.requestUnsuccessful(.unauthorized, let error)):
				XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDocNameInvalidAuthorization() async {
			let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
			let id: SchemaDoc.ID = "<SCHEMA_DOC_ID>"
			let request = api.updateName(ofSchemaDocWith: id, toName: "User Schema")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
			default:
				XCTFail()
			}
		}

		func testUpdateMissingSchemaDocName() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<MISSING_SCHEMA_DOC_ID>"
			let request = api.updateName(ofSchemaDocWith: id, toName: "User Schema")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "Schema Doc not found")
			default:
				XCTFail()
			}
		}

		func testUpdateSchemaDocNameWithInvalidID() async {
			let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
			let id: SchemaDoc.ID = "<INVALID_SCHEMA_DOC_ID>"
			let request = api.updateName(ofSchemaDocWith: id, toName: "User Schema")
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid Schema Id provided")
			default:
				XCTFail()
			}
		}
	}
#endif
