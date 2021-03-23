//
//  ContentView.swift
//  Example
//
//  Created by Emilio Peláez on 23/3/21.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		DirectoryFeaturedView(client: .init()) { }
			.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
