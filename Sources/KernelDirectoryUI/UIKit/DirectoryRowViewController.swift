//
//  DirectoryRowViewController.swift
//  Example-UIKit
//
//  Created by Emilio Peláez on 15/4/21.
//

#if canImport(UIKit)

import SwiftUI
import UIKit

class DirectoryRowViewController: UIHostingController<DirectoryRow> {
	
	let app: ApplicationInfo
	
	init(app: ApplicationInfo) {
		self.app = app
		super.init(rootView: DirectoryRow(app: app))
	}
	
	@available(*, unavailable)
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("Unsupported, use ini(client:)")
	}
	
}

#endif
