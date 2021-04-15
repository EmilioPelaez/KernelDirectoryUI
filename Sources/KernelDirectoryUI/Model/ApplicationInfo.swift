//
//  ApplicationInfo.swift
//  Created by Emilio Peláez on 22/3/21.
//

import Foundation
import RESTClient

public struct ApplicationInfo: Decodable {
	public let icon: URL
	public let name: String
	public let subtitle: String
	public let creator: String
	public let storeId: String
}

extension ApplicationInfo: Identifiable {
	public var id: String { storeId }
}

extension ApplicationInfo: Equatable {}

extension ApplicationInfo: RemoteResource {
	public static var path: String { "applications" }
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
