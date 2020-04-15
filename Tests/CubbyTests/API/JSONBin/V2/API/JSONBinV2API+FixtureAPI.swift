// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Cubby
import Emissary

extension JSONBin.V2.API: FixtureAPI {
	public var fixturesURL: URL {
		Bundle.module.url(forResource: "JSONBinV2APIFixtures", withExtension: "json")!
	}
}
