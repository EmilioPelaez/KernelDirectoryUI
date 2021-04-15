//
//  DirectoryFeaturedAppsView.swift
//  Example-UIKit
//
//  Created by Emilio Peláez on 15/4/21.
//

import Combine
import UIKit

class DirectoryFeaturedAppsView: UIView {

	let client: KernelClient
	
	var bag: Set<AnyCancellable> = []
	
	lazy var contentView: DirectoryFeaturedContentView? = {
		let nib = Bundle(for: DirectoryFeaturedContentView.self).loadNibNamed("DirectoryFeaturedContentView", owner: nil, options: nil)
		return nib?[0] as? DirectoryFeaturedContentView
	}()
	
	init(client: KernelClient) {
		self.client = client
		super.init(frame: .zero)
		
		setup()
		combine()
		client.fetchFeatured()
	}
	
	deinit {
		print("OH NO!")
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
	}
	
	private func combine() {
		client.$featured.sink { [weak self] state in
			guard let self = self, let contentView = self.contentView else { return }
			UIView.animate(withDuration: 0.25) {
				switch state {
				case .undefined:
					contentView.showEmptyState(buttonTitle: "Load Apps")
				case .loading:
					contentView.showEmptyState(message: "Loading...")
				case .failed:
					contentView.showEmptyState(message: "Unable to load.", buttonTitle: "Try Again")
				case .loaded(let apps):
					contentView.showApps(apps)
				}
			}
		}.store(in: &bag)
	}
}
