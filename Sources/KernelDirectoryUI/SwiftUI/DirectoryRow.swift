//
//  DirectoryRow.swift
//  Created by Emilio Peláez on 22/3/21.
//

#if canImport(UIKit)

import SwiftUI

struct DirectoryRow: View {
	
	let app: ApplicationInfo
	let style: KernelDirectoryStyle
	
	var body: some View {
		HStack(alignment: .top) {
			RemoteImage(url: app.icon, placeholder: style.iconPlaceholderColor)
				.aspectRatio(contentMode: .fill)
				.frame(width: 60, height: 60)
				.clipped()
				.mask(RoundedRectangle(cornerRadius: 15, style: .continuous))
			VStack(alignment: .leading, spacing: 4) {
				HStack {
					VStack(alignment: .leading) {
						Text(app.name)
							.foregroundColor(style.primaryTextColor)
							.font(.headline)
						Text(app.subtitle)
							.foregroundColor(style.secondaryTextColor)
							.font(.callout)
					}
				}
			}
			.padding(.top, 6)
			Spacer()
			Image(systemName: "icloud.and.arrow.down")
				.font(.system(size: 15, weight: .bold, design: .default))
				.foregroundColor(style.accentColor)
				.frame(width: 30, height: 30)
				.background(style.downloadButtonBackgroundColor)
				.mask(RoundedRectangle(cornerRadius: 6, style: .continuous))
				.padding(.top, 6)
		}
		.padding(8)
		.background(
			RoundedRectangle(cornerRadius: 8, style: .continuous)
				.foregroundColor(style.rowBackgroundColor)
		)
		
	}
}

struct DirectoryRow_Previews: PreviewProvider {
	static var previews: some View {
		DirectoryRow(app: .example, style: .default)
			.padding()
			.previewLayout(.sizeThatFits)
	}
}

#endif
