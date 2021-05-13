//
//  ContentView.swift
//  Example
//
//  Created by Emilio Peláez on 23/3/21.
//

import KernelDirectoryUI
import SwiftUI

struct ContentView: View {
	let client = KernelClient(appId: "1457799658")
	@State var showFullList = false
	
	var body: some View {
		VStack {
			DirectoryFeaturedView(client: client, style: .default) { showFullList = true }
				.padding()
			List {
				Section(header: DirectoryFeaturedView.title) {
					DirectoryFeaturedView(client: client, style: .groupedList) { showFullList = true }
						.padding(.vertical, 8)
				}
			}
			.listStyle(InsetGroupedListStyle())
		}
		.sheet(isPresented: $showFullList) {
			DirectoryModalView(client: client)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
