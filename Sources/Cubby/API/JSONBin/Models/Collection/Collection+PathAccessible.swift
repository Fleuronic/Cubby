// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

extension Collection: PathAccessible {
	// MARK: SubpathRepresentable
	public enum PathComponents: String, PathComponent {
		case collections = "c"
		case bins
		case uncategorized
		case schemaDoc = "schemadoc"
		case add
		case remove
	}

	public static var component: PathComponents {
		.collections
	}
}
