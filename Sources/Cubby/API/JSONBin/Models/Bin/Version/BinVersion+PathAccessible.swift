// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

extension Bin.Version: PathAccessible {
	// MARK: SubpathRepresentable
	public enum PathComponents: String, PathComponent {
		case versions
		case count
	}

	public static var component: PathComponents {
		.versions
	}
}
