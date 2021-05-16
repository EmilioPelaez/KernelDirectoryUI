//
//  DirectoryFeaturedContentView.swift
//  Example-UIKit
//
//  Created by Emilio Peláez on 15/4/21.
//

#if canImport(UIKit)

import UIKit

class DirectoryFeaturedContentView: UIView {
	
	@IBOutlet var appsContainer: UIStackView!
	
	@IBOutlet var titleLabel: UILabel!
	
	@IBOutlet var emptyStateContainer: UIView!
	@IBOutlet var emptyStateLabel: UILabel!
	@IBOutlet var emptyStateButton: UIButton!
	
	@IBOutlet var moreAppsButton: UIButton!
	@IBOutlet var infoButton: UIButton!
	
	var hostingControllers: [DirectoryRowViewController] = []
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		moreAppsButton.setTitle(Constant.moreApps, for: .normal)
		moreAppsButton.isHidden = true
	}
	
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
	
	func apply(_ style: KernelDirectoryStyle) {
		guard #available(iOS 14.0, *) else { return }
		guard let colors = style.uiKitColors else { return }
		titleLabel.textColor = colors.primaryTextColor
		emptyStateLabel.textColor = colors.primaryTextColor
		emptyStateButton.setTitleColor(colors.accentColor, for: .normal)
		infoButton.tintColor = colors.accentColor
	}
	
	@objc func tapAction(_ recognizer: UITapGestureRecognizer) {
		guard let view = recognizer.view, let index = appsContainer.arrangedSubviews.firstIndex(of: view) else {
			return
		}
		let app = hostingControllers[index].app
		guard let url = URL(string: Constant.storeUrlPrefix + app.id) else { return }
		UIApplication.shared.open(url)
	}
}

#endif
