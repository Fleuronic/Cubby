// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import Cubby

final class JSONBinV3APIOtherSpecTests: XCTestCase {
	func testListUsageLogs() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let request = api.listUsageLogs()
		let result = await request.returnedResult

		switch result {
		case let .success(list):
			XCTAssertEqual(list.logNames, ["01-01-1970", "01-02-1970", "01-03-1970"])
		default:
			XCTFail()
		}
	}

	func testListUsageLogsUnauthenticated() async {
		let api = JSONBin.V3.API()
		let request = api.listUsageLogs()
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
		default:
			XCTFail()
		}
	}

	func testListUsageLogsInvalidAuthorization() async {
		let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
		let request = api.listUsageLogs()
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
		default:
			XCTFail()
		}
	}

	func testDownloadUsageLog() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let request = api.downloadUsageLog(named: "01-01-1970")
		let result = await request.returnedResult
		let contents = "logs.txt\n"
		let compressedData = contents.data(using: .utf8)

		switch result {
		case let .success(usageLog):
			XCTAssertEqual(usageLog.compressedData, compressedData)
		default:
			XCTFail()
		}
	}

	func testDownloadUsageLogUnauthenticated() async {
		let api = JSONBin.V3.API()
		let request = api.downloadUsageLog(named: "01-01-1970")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "You need to pass X-Master-Key in the header")
		default:
			XCTFail()
		}
	}

	func testDownloadUsageLogInvalidAuthorization() async {
		let api = JSONBin.V3.API(secretKey: "<INVALID_SECRET_KEY>")
		let request = api.downloadUsageLog(named: "01-01-1970")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.unauthorized, error)):
			XCTAssertEqual(error.message, "Invalid X-Master-Key provided")
		default:
			XCTFail()
		}
	}

	func testDownloadMissingUsageLog() async {
		let api = JSONBin.V3.API(secretKey: "<SECRET_KEY>")
		let request = api.downloadUsageLog(named: "01-01-1969")
		let result = await request.returnedResult

		switch result {
		case let .failure(.requestUnsuccessful(.notFound, error)):
			XCTAssertEqual(error.message, "Backup not found for 01-01-1969.")
		default:
			XCTFail()
		}
	}
}
