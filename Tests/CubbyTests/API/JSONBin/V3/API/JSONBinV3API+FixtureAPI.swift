// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Cubby
import Emissary

extension JSONBin.V3.API: FixtureAPI {
	public var fixturesURL: URL {
		Bundle.module.url(forResource: "JSONBinV3APIFixtures", withExtension: "json")!
	}
}
