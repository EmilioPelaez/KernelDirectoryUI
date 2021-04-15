//
//  DirectoryListView.swift
//  Example
//
//  Created by Emilio Peláez on 5/4/21.
//

import SwiftUI

public struct DirectoryListView: View {
	
	@ObservedObject var client: KernelClient
	@State var listState: KernelClient.AllState = .undefined
	
	public var body: some View {
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
					Text("These apps are free to download, contain no ads and don't have any functionality restricted by In-App Purchases. They're totally free to use!")
						.lineLimit(nil)
						.font(.callout)
						.multilineTextAlignment(.leading)
						.foregroundColor(Color(.secondaryLabel))
						.frame(maxWidth: .infinity, alignment: .leading)
						.padding()
						.background(Color(.secondarySystemBackground))
						.mask(RoundedRectangle(cornerRadius: 6, style: .continuous))
					LazyVStack {
						ForEach(results) { app in
							DirectoryRow(app: app)
								.onTapGesture { openApp(app) }
						}
					}
					if state == .loaded {
						Button(action: client.fetchMore) {
							Text("Load More")
						}
					}
					Spacer()
				}
				
			}
		}
		.padding()
		.navigationTitle("More Apps")
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

struct DirectoryListView_Previews: PreviewProvider {
	static var previews: some View {
		DirectoryListView(client: KernelClient(all: .undefined))
	}
}
