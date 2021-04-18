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
		DirectoryFeaturedView(client: client) { showFullList = true }
			.padding()
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
