// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public protocol JSONBinV2APISpec {}

// MARK: -
public extension JSONBinV2APISpec {
	typealias API = JSONBin.V2.API
	typealias Request<Resource> = Emissary.Request<API.Response<Resource>, API>
}
