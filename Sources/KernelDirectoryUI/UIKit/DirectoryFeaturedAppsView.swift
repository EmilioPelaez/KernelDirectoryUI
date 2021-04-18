//
//  DirectoryFeaturedAppsView.swift
//  Example-UIKit
//
//  Created by Emilio Peláez on 15/4/21.
//

#if canImport(UIKit)

import Combine
import UIKit

public class DirectoryFeaturedAppsView: UIView {

	let client: KernelClient
	weak var presentingController: UIViewController?
	
	var bag: Set<AnyCancellable> = []
	
	lazy var contentView: DirectoryFeaturedContentView? = {
		let nib = Bundle.module.loadNibNamed("DirectoryFeaturedContentView", owner: nil, options: nil)
		return nib?[0] as? DirectoryFeaturedContentView
	}()
	
	public init(client: KernelClient, presentingController: UIViewController) {
		self.client = client
		self.presentingController = presentingController
		
		super.init(frame: .zero)
		
		setup()
		combine()
		client.fetchFeatured()
	}
	
	@available(*, unavailable)
	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("Unsupported, use ini(client:)")
	}
	
	private func setup() {
		guard let contentView = contentView else { return }
		
		translatesAutoresizingMaskIntoConstraints = false
		contentView.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(contentView)
		leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
		trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
		topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		
		contentView.infoButton.addTarget(self, action: #selector(infoAction), for: .touchUpInside)
	}
	
	private func combine() {
		client.$featured.sink { [weak self] state in
			guard let self = self, let contentView = self.contentView else { return }
			UIView.animate(withDuration: 0.25) {
				switch state {
				case .undefined:
					contentView.showEmptyState(buttonTitle: Constant.loadApps)
				case .loading:
					contentView.showEmptyState(message: Constant.loading)
				case .failed:
					contentView.showEmptyState(message: Constant.unableToLoad, buttonTitle: Constant.tryAgain)
				case .loaded(let apps):
					contentView.showApps(apps)
				}
			}
		}.store(in: &bag)
	}
	
	@objc func infoAction() {
		guard let presentingController = presentingController else { return }
		let alertController = UIAlertController(title: Constant.information, message: Constant.infoText, preferredStyle: .alert)
		let action = UIAlertAction(title: Constant.okay, style: .default)
		alertController.addAction(action)
		presentingController.present(alertController, animated: true)
	}
}

#endif
