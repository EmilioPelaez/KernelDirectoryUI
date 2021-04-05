//
//  DirectoryFullListView.swift
//  Example
//
//  Created by Emilio Peláez on 5/4/21.
//

import SwiftUI

struct DirectoryFullListView: View {
	
	@ObservedObject var client: KernelClient
	@State var listState: KernelClient.AllState = .undefined
	
	var body: some View {
		Group {
			switch listState {
			case .undefined:
				Button(action: client.fetchAll) {
					Text("Load Apps")
				}
			case .list(let results, _, .loading) where results.isEmpty:
				Text("Loading...")
			case .failed:
				VStack(spacing: 8) {
					Text("Unable to load.")
					Button(action: client.fetchAll) {
						Text("Try Again")
					}
				}
			case .list(let results, _, let state):
				VStack {
					LazyVStack {
						ForEach(results) { app in
							DirectoryRow(app: app)
								.onTapGesture { openApp(app) }
						}
					}
					if state == .loaded {
						Button(action: client.fetchAll) {
							Text("Load More")
						}
					}
					Spacer()
				}
				
			}
		}
		.padding()
		.onAppear {
			client.fetchAll()
			listState = client.all
		}
		.onChange(of: client.all) { all in
			withAnimation { listState = all }
		}
	}
	
	func openApp(_ app: ApplicationInfo) {
		guard let url = URL(string: "https://apps.apple.com/app/id" + app.id) else { return }
		UIApplication.shared.open(url)
	}
}

struct DirectoryFullListView_Previews: PreviewProvider {
	static var previews: some View {
		DirectoryFullListView(client: KernelClient(all: .undefined))
	}
}
