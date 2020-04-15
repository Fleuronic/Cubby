// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV2APIGeoIPSpec: JSONBinV2APISpec {
	func lookUpGeolocation(for ipAddress: IPAddress) -> Request<Lookup>
}

// MARK: -
public extension JSONBinV2APISpec {
	typealias Lookup = Geolocation.Lookup
}
