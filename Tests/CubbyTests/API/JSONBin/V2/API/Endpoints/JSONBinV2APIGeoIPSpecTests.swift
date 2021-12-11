// Copyright © Fleuronic LLC. All rights reserved.

import XCTest
import CoreLocation
import Cubby

#if swift(>=5.5)
	@available(iOS 15, macOS 12, watchOS 8, tvOS 15, *)
	final class JSONBinV2APIGeoIPSpecTests: XCTestCase {
		func testLookUpGeolocationIPv4Address() async {
			let api = JSONBin.V2.API()
			let ipAddressString = "141.158.45.225"
			let ipAddress = IPAddress(ipAddressString)
			let request = api.lookUpGeolocation(for: ipAddress)
			let result = await request.returnedResult

			switch result {
			case let .success(lookup):
				XCTAssertEqual(lookup.success, true)
				XCTAssertEqual(lookup.data.range, 2375953408..<2375953919)
				XCTAssertEqual(lookup.data.countryCode, "US")
				XCTAssertEqual(lookup.data.regionCode, "PA")
				XCTAssertEqual(lookup.data.isEUCountry, false)
				XCTAssertEqual(lookup.data.timeZone, "America/New_York")
				XCTAssertEqual(lookup.data.city, "Philadelphia")
				XCTAssertEqual(lookup.data.coordinates.latitude, 39.934)
				XCTAssertEqual(lookup.data.coordinates.longitude, -75.16)
				XCTAssertEqual(lookup.data.metroCode, 504)
				XCTAssertEqual(lookup.data.accuracyRadius, 1)
				XCTAssertEqual(lookup.ipAddressString, ipAddressString)
			default:
				XCTFail()
			}
		}

		func testLookUpGeolocationIPv6Address() async {
			let api = JSONBin.V2.API()
			let ipAddressString = "2600::"
			let ipAddress = IPAddress(ipAddressString)
			let request = api.lookUpGeolocation(for: ipAddress)
			let result = await request.returnedResult

			switch result {
			case let .success(lookup):
				XCTAssertEqual(lookup.success, true)
				XCTAssertNil(lookup.data.range)
				XCTAssertEqual(lookup.data.countryCode, "US")
				XCTAssertEqual(lookup.data.regionCode, "")
				XCTAssertEqual(lookup.data.isEUCountry, false)
				XCTAssertEqual(lookup.data.timeZone, "America/Chicago")
				XCTAssertEqual(lookup.data.city, "")
				XCTAssertEqual(lookup.data.coordinates.latitude, 37.751)
				XCTAssertEqual(lookup.data.coordinates.longitude, -97.822)
				XCTAssertNil(lookup.data.metroCode)
				XCTAssertEqual(lookup.data.accuracyRadius, 100)
				XCTAssertEqual(lookup.ipAddressString, ipAddressString)
			default:
				XCTFail()
			}
		}

		func testLookUpGeolocationNotFound() async {
			let api = JSONBin.V2.API()
			let ipAddress: IPAddress = "192.168.1.1"
			let request = api.lookUpGeolocation(for: ipAddress)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.notFound, error)):
				XCTAssertEqual(error.message, "No Data Found")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}

		func testLookUpGeolocationInvalidAddress() async {
			let api = JSONBin.V2.API()
			let ipAddress: IPAddress = "<INVALID_IP_ADDRESS>"
			let request = api.lookUpGeolocation(for: ipAddress)
			let result = await request.returnedResult

			switch result {
			case let .failure(.requestUnsuccessful(.unprocessableEntity, error)):
				XCTAssertEqual(error.message, "Invalid IP Address")
				XCTAssertEqual(error.success, false)
			default:
				XCTFail()
			}
		}
	}
#endif
