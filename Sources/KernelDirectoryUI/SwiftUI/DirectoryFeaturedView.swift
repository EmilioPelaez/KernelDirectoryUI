//
//  DirectoryFeaturedView.swift
//  Created by Emilio Peláez on 22/3/21.
//

#if canImport(UIKit)

import SwiftUI

@available(iOS 14.0, *)
public struct DirectoryFeaturedView: View {
	
	@ObservedObject var client: KernelClient
	@State var featuredState: KernelClient.FeaturedState = .undefined
	let viewAllAction: () -> Void
	
	public init(client: KernelClient, viewAllAction: @escaping () -> Void) {
		self.client = client
		self.viewAllAction = viewAllAction
	}
	
	public var body: some View {
		VStack(spacing: 16) {
			HStack {
				Text(Constant.moreFreeApps)
				Spacer()
			}
			.font(.headline)
			switch featuredState {
			case .loaded(let apps):
				VStack(alignment: .leading) {
					ForEach(apps) { app in
						DirectoryRow(app: app)
							.onTapGesture { openApp(app) }
					}
//					Button(action: viewAllAction) {
//						Text(Constant.moreApps)
//					}
				}
			case _:
				emptyView(featuredState)
			}
		}
		.onAppear {
			client.fetchFeatured()
			featuredState = client.featured
		}
		.onChange(of: client.featured) { featured in
			withAnimation { featuredState = featured }
		}
	}
	
	func emptyView(_ state: KernelClient.FeaturedState) -> some View {
		Group {
			switch state {
			case .undefined:
				Button(action: client.fetchFeatured) {
					Text(Constant.loadApps)
				}
			case .loading:
				Text(Constant.loading)
			case .failed:
				VStack(spacing: 8) {
					Text(Constant.unableToLoad)
					Button(action: client.fetchFeatured) {
						Text(Constant.unableToLoad)
					}
				}
			case .loaded:
				Text(Constant.unableToLoad)
			}
		}
		.padding()
		.frame(minHeight: 100, alignment: .center)
	}
	
	func openApp(_ app: ApplicationInfo) {
		guard let url = URL(string: Constant.storeUrlPrefix + app.id) else { return }
		UIApplication.shared.open(url)
	}
	
}

@available(iOS 14.0, *)
struct DirectoryFeaturedView_Previews: PreviewProvider {
	static var previews: some View {
		DirectoryFeaturedView(client: KernelClient(featured: .undefined)) { }
		
		DirectoryFeaturedView(client: KernelClient(featured: .failed)) { }
		
		DirectoryFeaturedView(client: KernelClient(featured: .loading)) { }
		
		DirectoryFeaturedView(client: KernelClient(featured: .loaded([]))) { }
	}
}

#endif
