//
//  RemoteImage.swift
//  Created by Emilio Peláez on 23/3/21.
//

#if canImport(UIKit)

import SwiftUI

struct RemoteImage<Placeholder: View>: View {
	
	@ObservedObject var loader = ImageLoader()
	let url: URL
	let placeholder: Placeholder
	
	init(url: URL, placeholder: Placeholder) {
		self.url = url
		self.placeholder = placeholder
	}
	
	var body: some View {
		Group {
			if let image = loader.state.image {
				image
					.resizable()
					.transition(.opacity)
			} else {
				placeholder
					.transition(.opacity)
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

#endif
