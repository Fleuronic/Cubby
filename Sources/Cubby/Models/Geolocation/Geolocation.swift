// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
#if canImport(CoreLocation)
import CoreLocation
#else
public typealias CLLocationDegrees = Double
public struct CLLocationCoordinate2D {
	public let latitude: CLLocationDegrees
	public let longitude: CLLocationDegrees
}
#endif

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
