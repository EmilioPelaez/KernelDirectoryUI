//
//  RemoteImage.swift
//  Created by Emilio Peláez on 23/3/21.
//

import SwiftUI

struct RemoteImage<Placeholder: View>: View {
	
	let loader = ImageLoader()
	let url: URL
	let placeholder: Placeholder
	
	init(url: URL, placeholder: Placeholder) {
		self.url = url
		self.placeholder = placeholder
	}
	
	var body: some View {
		Group {
			if let image = loader.state.image {
				image.resizable()
			} else {
				placeholder
			}
		}
		.onAppear { loader.download(url: url) }
	}
}

struct RemoteImage_Previews: PreviewProvider {
	static var previews: some View {
		RemoteImage(url: URL(fileURLWithPath: ""), placeholder: Color.red)
	}
}
