// Copyright © Fleuronic LLC. All rights reserved.

extension UsageLog.List: Decodable {
	// MARK: Decodable
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		logNames = try container.decode([String].self, forKey: .logNames)
	}
}

// MARK: -
private extension UsageLog.List {
	enum CodingKeys: String, CodingKey {
		case logNames = "logs"
	}
}
