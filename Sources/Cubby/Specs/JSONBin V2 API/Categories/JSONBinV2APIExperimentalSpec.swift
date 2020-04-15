// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV2APIExperimentalSpec: JSONBinV2APISpec {
	func requestCount() -> Request<Count>
}

// MARK: -
public extension JSONBinV2APIExperimentalSpec {
	typealias Count = Experimental.Request.Count
}
