// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV2APISpec {}

// MARK: -
public extension JSONBinV2APISpec {
	typealias API = JSONBin.V2.API
	typealias Request<Resource> = API.Request<Resource>
}
