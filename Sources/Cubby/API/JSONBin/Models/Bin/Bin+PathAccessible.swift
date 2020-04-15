// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

extension Bin: PathAccessible {
	// MARK: SubpathRepresentable
	public enum PathComponents: String, PathComponent {
		case bins = "b"
	}

	public static var component: PathComponents {
		.bins
	}
}
