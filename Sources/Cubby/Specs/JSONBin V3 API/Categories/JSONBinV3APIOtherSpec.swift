// Copyright © Fleuronic LLC. All rights reserved.

public protocol JSONBinV3APIOtherSpec: JSONBinV3APISpec {
	func listUsageLogs() -> Request<UsageLog.List>
	func downloadUsageLog(named name: String) -> Request<UsageLog>
}
