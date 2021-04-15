//
//  DirectoryListModalController.swift
//  Example-UIKit
//
//  Created by Emilio Peláez on 15/4/21.
//

import UIKit

public class DirectoryListModalController: UINavigationController {
	
	public init(client: KernelClient) {
		let listController = DirectoryListViewController(client: client)
		super.init(rootViewController: listController)
		
		let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeAction))
		listController.navigationItem.leftBarButtonItem = closeButton
	}
	
	@available(*, unavailable)
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("Unsupported, use ini(client:)")
	}
	
	@objc func closeAction() {
		dismiss(animated: true)
	}
	
}
