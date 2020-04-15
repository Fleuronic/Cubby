// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV3APISpec {}

// MARK: -
public extension JSONBinV3APISpec {
	typealias API = JSONBin.V3.API
	typealias Request<Resource> = API.Request<Resource>
}
