//
//  File.swift
//  
//
//  Created by Emilio Peláez on 22/3/21.
//

import Foundation
import RESTClient

struct KernelRouter: Router {
	enum Route: String {
		case all
		case featured
	}
	
	let route: Route
	
	func url<T>(for type: T.Type, baseURL: URL) -> URL {
		baseURL.appendingPathComponent(route.rawValue)
	}
	
}
