// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Cubby

#if swift(>=5.5)
	#if swift(<5.5.2)
		@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	#endif
	final class JSONBinV2APIExperimentalSpecTests: XCTestCase {
		func testRequestCount() async {
			let api = JSONBin.V2.API(secretKey: "<SECRET_KEY>")
			let request = api.requestCount()
			let result = await request.returnedResult

			switch result {
			case let .success(count):
				XCTAssertEqual(count.value, 100000)
			default:
				XCTFail()
			}
		}

		func testRequestCountUnauthenticated() async {
			let api = JSONBin.V2.API()
			let request = api.requestCount()
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Need to provide a secret-key to fetch Pending Requests Count")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testRequestCountInvalidAuthorization() async {
			let api = JSONBin.V2.API(secretKey: "<INVALID_SECRET_KEY>")
			let request = api.requestCount()
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unauthorized, error)):
				XCTAssertEqual(error.message, "Invalid secret key provided.")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}
	}
#endif
