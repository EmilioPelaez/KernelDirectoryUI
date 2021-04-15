//
//  DirectoryFeaturedContentView.swift
//  Example-UIKit
//
//  Created by Emilio Peláez on 15/4/21.
//

import UIKit

class DirectoryFeaturedContentView: UIView {
	
	@IBOutlet var appsContainer: UIStackView!
	
	@IBOutlet var emptyStateContainer: UIView!
	@IBOutlet var emptyStateLabel: UILabel!
	@IBOutlet var emptyStateButton: UIButton!
	
	var hostingControllers: [DirectoryRowViewController] = []
	
	func showApps(_ apps: [ApplicationInfo]) {
		if appsContainer.isHidden {
			appsContainer.isHidden = false
		}
		if !emptyStateContainer.isHidden {
			emptyStateContainer.isHidden = true
		}
		
		while let last = appsContainer.arrangedSubviews.last {
			appsContainer.removeArrangedSubview(last)
			appsContainer.removeFromSuperview()
		}
		
		let controllers = apps.map(DirectoryRowViewController.init)
		controllers.map(\.view).forEach { view in
			view.map(appsContainer.addArrangedSubview)
			view?.sizeToFit()
			view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
		}
		self.hostingControllers = controllers
	}
	
	func showEmptyState(message: String? = nil, buttonTitle: String? = nil) {
		if emptyStateContainer.isHidden {
			emptyStateContainer.isHidden = false
		}
		if !appsContainer.isHidden {
			appsContainer.isHidden = true
		}
		
		emptyStateLabel.text = message
		emptyStateLabel.isHidden = message == nil
		emptyStateButton.setTitle(buttonTitle, for: .normal)
		emptyStateButton.isHidden = buttonTitle == nil
	}
	
	@objc func tapAction(_ recognizer: UITapGestureRecognizer) {
		guard let view = recognizer.view, let index = appsContainer.arrangedSubviews.firstIndex(of: view) else {
			return
		}
		let app = hostingControllers[index].app
		guard let url = URL(string: "https://apps.apple.com/app/id" + app.id) else { return }
		UIApplication.shared.open(url)
	}
	
}
