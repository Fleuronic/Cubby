// Copyright © Fleuronic LLC. All rights reserved.

extension JSONBin.V2.API: JSONBinV2APIGeoIPSpec {
	public func lookUpGeolocation(for ipAddress: IPAddress) -> Request<Lookup> {
		let path = Geolocation.path(to: ipAddress.stringValue)
		return getResource(at: path)
	}
}
