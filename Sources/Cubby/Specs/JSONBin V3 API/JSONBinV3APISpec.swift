// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public protocol JSONBinV3APISpec {}

// MARK: -
public extension JSONBinV3APISpec {
	typealias API = JSONBin.V3.API
	typealias Request<Resource> = Emissary.Request<API.Response<Resource>, API>
}
