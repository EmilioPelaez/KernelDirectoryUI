//
//  ApplicationInfo.swift
//  Created by Emilio Peláez on 22/3/21.
//

import Foundation

struct ApplicationInfo: Decodable {
	let icon: URL
	let name: String
	let subtitle: String
	let creator: String
	let storeId: String
}
