// Copyright © Fleuronic LLC. All rights reserved.

extension JSONBin.V3.API: JSONBinV3APIOtherSpec {
	public func listUsageLogs() -> Request<UsageLog.List> {
		let path = UsageLog.List.path
		return getResource(at: path)
	}

	public func downloadUsageLog(named name: String) -> Request<UsageLog> {
		let path = UsageLog.List.path(to: name)
		return getResource(at: path)
	}
}
