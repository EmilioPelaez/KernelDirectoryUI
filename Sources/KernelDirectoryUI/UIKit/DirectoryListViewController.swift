//
//  DirectoryListViewController.swift
//  Example-UIKit
//
//  Created by Emilio Peláez on 15/4/21.
//

import SwiftUI
import UIKit

class DirectoryListViewController: UIHostingController<DirectoryListView> {
	init(client: KernelClient) {
		super.init(rootView: .init(client: client))
		
		title = "More Apps"
	}
	
	@available(*, unavailable)
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("Unsupported, use ini(client:)")
	}
}
