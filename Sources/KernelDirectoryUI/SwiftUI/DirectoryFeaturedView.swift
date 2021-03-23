//
//  DirectoryFeaturedView.swift
//  Created by Emilio Peláez on 22/3/21.
//

#if canImport(UIKit)

import SwiftUI

struct DirectoryFeaturedView: View {
	
	@ObservedObject var client: KernelClient
	let viewAllAction: () -> Void
	
	var body: some View {
		VStack(spacing: 16) {
			HStack {
				Text("More Free Apps")
				Spacer()
			}
			.font(.headline)
			switch client.featured {
			case .loaded(let apps):
				VStack(alignment: .leading) {
					ForEach(apps) {
						DirectoryRow(app: $0)
					}
					Button(action: viewAllAction) {
						Text("View All")
					}
				}
			case _:
				emptyView(client.featured)
			}
		}
		.frame(minWidth: 300, maxWidth: 450, alignment: .top)
		.onAppear { client.fetchFeatured() }
	}
	
	func emptyView(_ state: KernelClient.State) -> some View {
		Group {
			switch state {
			case .undefined:
				Button(action: client.fetchFeatured) {
					Text("Load Apps")
				}
			case .loading:
				Text("Loading...")
			case .failed:
				VStack(spacing: 8) {
					Text("Unable to load.")
					Button(action: client.fetchFeatured) {
						Text("Try Again")
					}
				}
			case .loaded:
				Text("Unable to load.")
			}
		}
		.padding()
		.frame(minHeight: 100, alignment: .center)
	}
}

struct DirectoryFeaturedView_Previews: PreviewProvider {
	static var previews: some View {
		DirectoryFeaturedView(client: KernelClient(featured: .undefined)) { }
		
		DirectoryFeaturedView(client: KernelClient(featured: .failed)) { }
		
		DirectoryFeaturedView(client: KernelClient(featured: .loading)) { }
		
		DirectoryFeaturedView(client: KernelClient(featured: .loaded(featured: []))) { }
	}
}

#endif
