// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Emissary

extension UsageLog: DataDecodable {
	// MARK: DataDecodable
	public init(from data: Data) {
		compressedData = data
	}
}
