//
//  ContentView.swift
//  Example
//
//  Created by Emilio Peláez on 23/3/21.
//

import SwiftUI

struct ContentView: View {
	@State var showFullList = false
	
	var body: some View {
		DirectoryFeaturedView(client: .init()) { showFullList = true }
			.padding()
			.sheet(isPresented: $showFullList) {
				DirectoryFullListView(client: .init())
			}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
