//
//  Client.swift
//  Created by Emilio Peláez on 22/3/21.
//

import Combine
import Foundation
import RESTClient

public class KernelClient: ObservableObject {
	
	enum FeaturedState {
		case undefined
		case loading
		case failed
		case loaded([ApplicationInfo])
	}
	
	enum AllState {
		enum LoadingState {
			case loading
			case loaded
			case loadedAll
		}
		
		case undefined
		case failed([ApplicationInfo], Page)
		case list([ApplicationInfo], Page, LoadingState)
	}
	
	public let appId: String
	private let client: PaginatedClient<Page>
	private let featuredRouter = KernelRouter(route: .featured)
	
	@Published var all: AllState
	@Published var featured: FeaturedState
	
	private var bag: Set<AnyCancellable> = []
	
	/*
		appId is the StoreId is the App Store id of your app, it should contain only numbers (i.e. 1457799658)
		It will be used to filter your app from the featured list.
	*/
	public convenience init(appId: String = "") {
		self.init(appId: appId, all: .undefined, featured: .undefined)
	}
	
	convenience init(all: AllState) {
		self.init(appId: "", all: all, featured: .undefined)
	}
	
	convenience init(featured: FeaturedState) {
		self.init(appId: "", all: .undefined, featured: featured)
	}
	
	init(appId: String, all: AllState, featured: FeaturedState) {
		guard let url = URL(string: "https://api.kernelproject.com") else {
			preconditionFailure("Couldn't create URL")
		}
		self.appId = appId
		self.client = PaginatedClient(baseUrl: url, pageSizeKey: "size")
		self.all = all
		self.featured = featured
		
		self.client.requestConfiguration = { request in
			guard let url = request.url else { return }
			guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return }
			components.queryItems = (components.queryItems ?? []) + [URLQueryItem(name: "appId", value: appId)]
			guard let finalUrl = components.url else { return }
			request.url = finalUrl
		}
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
						featured = .loaded(try result.get())
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
		case .undefined:
			fetch()
		case let .failed(results, page):
			fetch(results: results, page: page)
		case _: break
		}
	}
	
	func fetchMore() {
		switch all {
		case .undefined:
			fetch()
		case let .failed(results, page):
			fetch(results: results, page: page)
		case .list(let results, let page, .loaded):
			fetch(results: results, page: page)
		case _: break
		}
	}
	
	let pageSize = 1
	private func fetch(results: [ApplicationInfo] = [], page: Page? = nil) {
		let page = page ?? Page(page: -1, size: 0, total: 0)
		all = .list(results, page, .loading)
		client.page(ApplicationInfo.self, page: page.page + 1, pageSize: pageSize)
			.receive(on: RunLoop.main)
			.result { [self] result in
				do {
					let response = try result.get()
					let newResults = results + response.results
					if newResults.count < response.page.total {
						all = .list(newResults, response.page, .loaded)
					} else {
						all = .list(newResults, response.page, .loadedAll)
					}
				} catch {
					all = .failed(results, page)
				}
			}
			.store(in: &bag)
	}
	
}

extension KernelClient.FeaturedState: CustomStringConvertible {
	var description: String {
		switch self {
		case .undefined: return "Undefined"
		case .loading: return "Loading"
		case .failed: return "Failed"
		case .loaded(let featured): return "Loaded: \(featured.count)"
		}
	}
}

extension KernelClient.FeaturedState: Equatable {
	static func == (lhs: KernelClient.FeaturedState, rhs: KernelClient.FeaturedState) -> Bool {
		switch (lhs, rhs) {
		case (.undefined, .undefined): return true
		case (.loading, .loading): return true
		case (.failed, .failed): return true
		case let (.loaded(lhsData), .loaded(rhsData)): return lhsData == rhsData
		case _: return false
		}
	}
}

extension KernelClient.AllState: Equatable {
	static func == (lhs: KernelClient.AllState, rhs: KernelClient.AllState) -> Bool {
		switch (lhs, rhs) {
		case (.undefined, .undefined):
			return true
		case let (.failed(lhsResults, lhsPage), .failed(rhsResults, rhsPage)):
			return lhsResults == rhsResults && lhsPage == rhsPage
		case let (.list(lhsResults, lhsPage, lhsState), .list(rhsResults, rhsPage, rhsState)):
			return lhsResults == rhsResults && lhsPage == rhsPage && lhsState == rhsState
		case _: return false
		}
	}
}
