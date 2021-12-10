// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import CoreLocation

public struct Geolocation {
	public let range: Range<Int64>?
	public let countryCode: String
	public let regionCode: String
	public let isEUCountry: Bool
	public let timeZone: TimeZone
	public let city: String
	public let coordinates: CLLocationCoordinate2D
	public let metroCode: Int?
	public let accuracyRadius: Int
}
