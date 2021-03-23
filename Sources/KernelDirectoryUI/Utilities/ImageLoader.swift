//
//  ImageLoader.swift
//  Created by Emilio Peláez on 23/3/21.
//

import Combine
import Foundation
import SwiftUI
import UIKit

class ImageLoader: ObservableObject {
	
	enum State {
		case waiting
		case loading
		case error
		case loaded(Image)
		
		var canStart: Bool {
			switch self {
			case .waiting, .error: return true
			case .loading, .loaded: return false
			}
		}
		
		var image: Image? {
			switch self {
			case .loaded(let image): return image
			case _: return nil
			}
		}
	}
	
	@Published var state: State = .waiting
	
	private let session: URLSession = .shared
	private var bag: Set<AnyCancellable> = []
	
	init() { }
	
	func download(url: URL) {
		guard state.canStart else { return }
		state = .loading
		session.dataTaskPublisher(for: url)
			.map(\.data)
			.map(UIImage.init)
			.mapError { $0 as Error }
			.receive(on: RunLoop.main)
			.result(handler: handle)
			.store(in: &bag)
	}
	
	private func handle(_ result: Result<UIImage?, Error>) {
		if let image = try? result.get() {
			withAnimation {
				state = .loaded(Image(uiImage: image))
			}
		} else {
			state = .error
		}
	}
	
}
