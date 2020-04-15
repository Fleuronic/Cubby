// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

extension Experimental: PathAccessible {
	// MARK: SubpathRepresentable
	public enum PathComponents: String, PathComponent {
		case experimental = "e"
		case requests
	}

	public static var component: PathComponents {
		.experimental
	}
}
