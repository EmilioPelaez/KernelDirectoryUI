//
//  DirectoryListViewController.swift
//  Example-UIKit
//
//  Created by Emilio Peláez on 15/4/21.
//

#if canImport(UIKit)

import SwiftUI
import UIKit

@available(iOS 14.0, *)
public class DirectoryListViewController: UIHostingController<DirectoryListView> {
	
	public init(client: KernelClient) {
		super.init(rootView: .init(client: client))
		
		title = Constant.moreApps
	}
	
	@available(*, unavailable)
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("Unsupported, use ini(client:)")
	}
	
}

#endif
