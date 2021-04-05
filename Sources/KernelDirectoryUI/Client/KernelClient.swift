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
	private let featuredRouter = KernelRouter(route: .featured)
	
	@Published var all: State
	@Published var featured: State
	
	private var bag: Set<AnyCancellable> = []
	
	init(all: State = .undefined, featured: State = .undefined) {
		guard let url = URL(string: "https://api.kernelproject.com") else {
			preconditionFailure("Couldn't create URL")
		}
		self.client = RESTClient(baseUrl: url)
		self.all = all
		self.featured = featured
	}
	
	func fetchFeatured() {
		switch featured {
		case .undefined, .failed:
			featured = .loading
			client
				.all(ApplicationInfo.self, router: featuredRouter)
				.receive(on: RunLoop.main)
				.result { [self] result in
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
			client
				.all(ApplicationInfo.self)
				.receive(on: RunLoop.main)
				.result { [self] result in
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

extension KernelClient.State: CustomStringConvertible {
	var description: String {
		switch self {
		case .undefined: return "Undefined"
		case .loading: return "Loading"
		case .failed: return "Failed"
		case .loaded(let featured): return "Loaded: \(featured.count)"
		}
	}
}

extension KernelClient.State: Equatable {
	static func == (lhs: KernelClient.State, rhs: KernelClient.State) -> Bool {
		switch (lhs, rhs) {
		case (.undefined, .undefined): return true
		case (.loading, .loading): return true
		case (.failed, .failed): return true
		case let (.loaded(lhsData), .loaded(rhsData)): return lhsData == rhsData
		case _: return false
		}
	}
}
