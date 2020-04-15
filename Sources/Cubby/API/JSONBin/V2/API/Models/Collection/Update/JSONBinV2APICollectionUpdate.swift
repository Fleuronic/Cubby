// Copyright © Fleuronic LLC. All rights reserved.

public extension JSONBin.V2.API.Collection {
	struct Update {
		public let success: Bool
		public let collectionID: Collection.ID?
		public let collectionDetails: Details?
		public let schemaDocID: SchemaDoc.ID?
		public let schemaDocDetails: Details?
	}
}

// MARK: -
public extension JSONBin.V2.API.Collection.Update {
	typealias Details = JSONBin.V2.API.Collection.Details
}

// MARK: -
extension JSONBin.V2.API.Collection.Update: Decodable {
	enum CodingKeys: String, CodingKey {
		case success
		case data
		case collectionID
		case collectionDetails
		case schemaDocID
		case schemaDocDetails
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		success = try container.decode(Bool.self, forKey: .success)
		collectionID = try container.decodeIfPresent(Collection.ID.self, forKey: .collectionID)
		collectionDetails =
			try container.decodeIfPresent(Details.self, forKey: .collectionDetails) ??
			container.decodeIfPresent(Details.self, forKey: .data)
		schemaDocID = try container.decodeIfPresent(SchemaDoc.ID.self, forKey: .schemaDocID)
		schemaDocDetails = try container.decodeIfPresent(Details.self, forKey: .schemaDocDetails)
	}
}
