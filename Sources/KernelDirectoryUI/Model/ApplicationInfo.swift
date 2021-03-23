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

extension ApplicationInfo: Identifiable {
	var id: String { storeId }
}

extension ApplicationInfo {
	static let examples: [ApplicationInfo] = {
		guard let url = Bundle(for: KernelClient.self).url(forResource: "AppList", withExtension: "json") else {
			preconditionFailure("File not found")
		}
		do {
			let data = try Data(contentsOf: url)
			let decoder = JSONDecoder()
			let list = try decoder.decode([ApplicationInfo].self, from: data)
			return list
		} catch {
			preconditionFailure("Unable to load \(error.localizedDescription)")
		}
	}()
	
	static var example: ApplicationInfo { examples[0] }
}
