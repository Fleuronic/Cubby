// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

public extension JSONBin.V3.API {
	enum Meta {}
}

// MARK: -
extension JSONBin.V3.API.Meta: PathAccessible {
	// MARK: SubpathRepresentable
	public enum PathComponents: String, PathComponent {
		case meta
		case name
		case privacy
	}

	public static var component: PathComponents {
		.meta
	}
}
