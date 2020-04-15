// Copyright © Fleuronic LLC. All rights reserved.

import Emissary

extension UsageLog.List: PathAccessible {
	// MARK: SubpathRepresentable
	public enum PathComponents: String, PathComponent {
		case logs = "l"
	}

	public static var component: PathComponents {
		.logs
	}
}
