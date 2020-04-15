// Copyright © Fleuronic LLC. All rights reserved.

extension JSONBin.V2.API: JSONBinV2APIExperimentalSpec {
	public func requestCount() -> Request<Count> {
		let path = Experimental.path(to: .requests)
		return getResource(at: path)
	}
}
