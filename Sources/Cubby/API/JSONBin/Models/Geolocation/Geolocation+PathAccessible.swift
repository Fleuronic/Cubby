// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

extension Geolocation: PathAccessible {
	// MARK: SubpathRepresentable
	public enum PathComponents: String, PathComponent {
		case geolocation = "g"
	}

	public static var component: PathComponents {
		.geolocation
	}
}
