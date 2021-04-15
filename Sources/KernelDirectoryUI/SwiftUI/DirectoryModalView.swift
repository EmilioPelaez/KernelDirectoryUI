//
//  DirectoryModalView.swift
//  Example
//
//  Created by Emilio Peláez on 14/4/21.
//

#if canImport(UIKit)

import SwiftUI

@available(iOS 14.0, *)
public struct DirectoryModalView: View {
	
	@Environment(\.presentationMode) var presentationMode
	
	let client: KernelClient
	
	public init(client: KernelClient) {
		self.client = client
	}
	
	public var body: some View {
		NavigationView {
			DirectoryListView(client: client)
				.navigationBarItems(leading: closeButton)
		}
	}
	
	func closeAction() {
		presentationMode.wrappedValue.dismiss()
	}
	
	var closeButton: some View {
		Button(action: closeAction) {
			Image(systemName: "xmark")
				.foregroundColor(Color(.systemGray))
				.font(.system(size: 15, weight: .bold))
				.frame(width: 30, height: 30)
				.background(Color(.systemGray4).opacity(0.5))
				.clipShape(Circle())
		}
	}
}

@available(iOS 14.0, *)
struct DirectoryModalView_Previews: PreviewProvider {
	static var previews: some View {
		DirectoryModalView(client: .init())
	}
}

#endif
