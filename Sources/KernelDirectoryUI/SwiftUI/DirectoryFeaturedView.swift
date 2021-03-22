//
//  DirectoryFeaturedView.swift
//  Created by Emilio Peláez on 22/3/21.
//

import SwiftUI

struct DirectoryFeaturedView: View {
	
	@ObservedObject var client: KernelClient
	
	var body: some View {
		switch client.featured {
		case .undefined:
			VStack {
				Text("Kernel Directory")
				Button {
					client.fetchFeatured()
				}
				label: {
					Text("Load")
				}
			}
		case .loading:
			Text("Loading...")
		case .failed:
			VStack {
				Text("Unable to load apps.")
				Button {
					client.fetchFeatured()
				}
				label: {
					Text("Reload")
				}
			}
		case .loaded(let apps) where apps.isEmpty:
			Text("No apps found.")
		case .loaded(let apps):
			Text("\(apps.count) apps")
		}
	}
}

struct SwiftUIView_Previews: PreviewProvider {
	static var previews: some View {
		DirectoryFeaturedView(client: KernelClient(featured: .undefined))
		
		DirectoryFeaturedView(client: KernelClient(featured: .failed))
		
		DirectoryFeaturedView(client: KernelClient(featured: .loading))
		
		DirectoryFeaturedView(client: KernelClient(featured: .loaded(featured: [])))
	}
}
