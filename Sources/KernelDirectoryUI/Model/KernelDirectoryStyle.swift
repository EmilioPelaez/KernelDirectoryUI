//
//  KernelDirectoryStyle.swift
//  Created by Emilio Peláez on 9/5/21.
//

import SwiftUI

public struct KernelDirectoryStyle {
	let showTitle: Bool
	
	let primaryTextColor: Color
	let secondaryTextColor: Color
	
	let accentColor: Color
	
	let iconPlaceholderColor: Color
	
	let rowBackgroundColor: Color
	let downloadButtonBackgroundColor: Color
	
	public static let `default` = KernelDirectoryStyle(showTitle: true,
																										 primaryTextColor: .primary,
																										 secondaryTextColor: .secondary,
																										 accentColor: .blue,
																										 iconPlaceholderColor: Color(.tertiarySystemBackground),
																										 rowBackgroundColor: Color(.secondarySystemBackground),
																										 downloadButtonBackgroundColor: Color(.tertiarySystemBackground))
	
	public static let groupedList = KernelDirectoryStyle(showTitle: false,
																												primaryTextColor: .primary,
																												secondaryTextColor: .secondary,
																												accentColor: .blue,
																												iconPlaceholderColor: Color(.secondarySystemGroupedBackground),
																												rowBackgroundColor: Color(.tertiarySystemGroupedBackground),
																												downloadButtonBackgroundColor: Color(.secondarySystemGroupedBackground))
}
