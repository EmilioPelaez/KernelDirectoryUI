//
//  Client.swift
//  Created by Emilio Peláez on 22/3/21.
//

import Combine
import Foundation
import RESTClient

class KernelClient: ObservableObject {
	
	enum State {
		case undefined
		case loading
		case failed
		case loaded(featured: [ApplicationInfo])
	}
	
	private let client: RESTClient
	private let allRouter = KernelRouter(route: .all)
	private let featuredRouter = KernelRouter(route: .featured)
	
	@Published var all: State = .undefined
	@Published var featured: State = .undefined
	
	private var bag: Set<AnyCancellable> = []
	
	init() {
		guard let url = URL(string: "http://kernel-directory.heroku.com") else {
			preconditionFailure("Couldn't create URL")
		}
		self.client = RESTClient(baseUrl: url)
	}
	
	func fetchFeatured() {
		switch featured {
		case .undefined, .failed:
			featured = .loading
			client.all(ApplicationInfo.self, router: featuredRouter).result { [self] result in
				do {
					featured = .loaded(featured: try result.get())
				} catch {
					featured = .failed
				}
			}
			.store(in: &bag)
		case .loaded: break
		case .loading: break
		}
	}
	
	func fetchAll() {
		switch all {
		case .undefined, .failed:
			featured = .loading
			client.all(ApplicationInfo.self, router: allRouter).result { [self] result in
				do {
					all = .loaded(featured: try result.get())
				} catch {
					all = .failed
				}
			}
			.store(in: &bag)
		case .loaded: break
		case .loading: break
		}
	}
	
}
