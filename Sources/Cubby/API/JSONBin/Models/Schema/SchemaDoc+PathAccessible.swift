// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

extension SchemaDoc: PathAccessible {
	// MARK: SubpathRepresentable
	public enum PathComponents: String, PathComponent {
		case schemaDocs = "s"
	}

	public static var component: PathComponents {
		.schemaDocs
	}
}
