//
//  ViewController.swift
//  Example
//
//  Created by Emilio Peláez on 15/4/21.
//

import UIKit

class ViewController: UIViewController {
	
	let client = KernelClient()
	
	override func viewDidLoad() {
		super.viewDidLoad()
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
