//
//  Publisher.swift
//  Created by Emilio Peláez on 22/3/21.
//

import Combine
import Foundation

extension Publisher {
	
	func result(handler: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
		sink {
			guard case let .failure(error) = $0 else { return }
			handler(.failure(error))
		} receiveValue: {
			handler(.success($0))
		}
	}
	
}
