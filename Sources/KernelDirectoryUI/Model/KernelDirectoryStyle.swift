//
//  KernelDirectoryStyle.swift
//  Created by Emilio Peláez on 9/5/21.
//

import SwiftUI

public struct KernelDirectoryStyle {
	let primaryTextColor: Color
	let secondaryTextColor: Color
	
	let accentColor: Color
	
	let iconPlaceholderColor: Color
	
	let rowBackgroundColor: Color
	let downloadButtonBackgroundColor: Color
	
	public static let `default` = KernelDirectoryStyle(primaryTextColor: .primary,
																							secondaryTextColor: .secondary,
																							accentColor: .blue,
																							iconPlaceholderColor: Color(.tertiarySystemBackground),
																							rowBackgroundColor: Color(.secondarySystemBackground),
																							downloadButtonBackgroundColor: Color(.tertiarySystemBackground))
}
