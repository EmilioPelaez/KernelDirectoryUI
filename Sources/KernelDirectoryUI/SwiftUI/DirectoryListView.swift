//
//  DirectoryListView.swift
//  Example
//
//  Created by Emilio Peláez on 5/4/21.
//

#if canImport(UIKit)

import SwiftUI

@available(iOS 14.0, *)
public struct DirectoryListView: View {
	
	@ObservedObject var client: KernelClient
	@State var listState: KernelClient.AllState = .undefined
	
	public var body: some View {
		Group {
			switch listState {
			case .undefined:
				Button(action: client.fetchAll) {
					Text(Constant.loadApps)
				}
			case .list(let results, _, .loading) where results.isEmpty:
				Text(Constant.loading)
			case .failed:
				VStack(spacing: 8) {
					Text(Constant.unableToLoad)
					Button(action: client.fetchAll) {
						Text(Constant.tryAgain)
					}
				}
			case .list(let results, _, let state):
				VStack {
					Text(Constant.infoText)
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
							Text(Constant.loadMore)
						}
					}
					Spacer()
				}
				
			}
		}
		.padding()
		.navigationTitle(Constant.moreApps)
		.onAppear {
			client.fetchAll()
			listState = client.all
		}
		.onChange(of: client.all) { all in
			withAnimation { listState = all }
		}
	}
	
	func openApp(_ app: ApplicationInfo) {
		guard let url = URL(string: Constant.storeUrlPrefix + app.id) else { return }
		UIApplication.shared.open(url)
	}
}

@available(iOS 14.0, *)
struct DirectoryListView_Previews: PreviewProvider {
	static var previews: some View {
		DirectoryListView(client: KernelClient(all: .undefined))
	}
}

#endif
