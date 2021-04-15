//
//  ViewController.swift
//  Example
//
//  Created by Emilio Peláez on 15/4/21.
//

import UIKit
import KernelDirectoryUI

@available(iOS 14.0, *)
class ViewController: UIViewController {
	
	let client = KernelClient()
	
	@IBOutlet var stackView: UIStackView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let featuredViewController = DirectoryFeaturedAppsView(client: client)
		stackView.addArrangedSubview(featuredViewController)
	}
	
	@IBAction func pushAction() {
		let listController = DirectoryListViewController(client: client)
		navigationController?.pushViewController(listController, animated: true)
	}
	
	@IBAction func presentAction() {
		let modalController = DirectoryListModalController(client: client)
		present(modalController, animated: true)
	}
	
}
