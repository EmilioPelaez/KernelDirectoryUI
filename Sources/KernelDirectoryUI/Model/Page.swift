//
//  Page.swift
//  Example
//
//  Created by Emilio Peláez on 6/4/21.
//

import Foundation

struct Page {
	let page: Int
	let size: Int
	let total: Int
}

extension Page: Codable {}

extension Page: Equatable {}
