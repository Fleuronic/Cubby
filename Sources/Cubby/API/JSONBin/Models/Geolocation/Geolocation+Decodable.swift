// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import CoreLocation

extension Geolocation: Decodable {
	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		let isEUCountryString = try container.decode(String.self, forKey: .isEUCountryString)
		let timeZoneName = try container.decode(String.self, forKey: .timeZoneName)
		let coordinateDegrees = try container.decode([CLLocationDegrees].self, forKey: .coordinateDegrees)
		let metroCodeValue = try container.decode(Int.self, forKey: .metroCode)

		range = try? container.decode(Range<Int64>.self, forKey: .range)
		countryCode = try container.decode(String.self, forKey: .countryCode)
		regionCode = try container.decode(String.self, forKey: .regionCode)
		isEUCountry = (isEUCountryString == "1")
		timeZone = TimeZone(identifier: timeZoneName)!
		city = try container.decode(String.self, forKey: .city)
		coordinates = CLLocationCoordinate2D(latitude: coordinateDegrees[0], longitude: coordinateDegrees[1])
		metroCode = metroCodeValue == 0 ? nil : metroCodeValue
		accuracyRadius = try container.decode(Int.self, forKey: .accuracyRadius)
	}
}

// MARK: -
private extension Geolocation {
	enum CodingKeys: String, CodingKey {
		case range
		case countryCode = "country"
		case regionCode = "region"
		case isEUCountryString = "eu"
		case timeZoneName = "timezone"
		case city
		case coordinateDegrees = "ll"
		case metroCode = "metro"
		case accuracyRadius = "area"
	}
}
