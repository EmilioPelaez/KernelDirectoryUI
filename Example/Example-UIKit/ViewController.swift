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
		self.navigationController?.pushViewController(listController, animated: true)
	}
	
	@IBAction func presentAction() {
		
	}
	
}
