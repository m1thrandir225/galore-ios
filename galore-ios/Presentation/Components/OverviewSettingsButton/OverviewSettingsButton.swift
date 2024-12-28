//
//  OverviewSettingsButton.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//

import SwiftUI

struct OverviewSettingsButton: View {
	let title: String
	let icon: String
	let action: () -> Void
	let hasIcon: Bool
	
    var body: some View {
		Button {
			action()
		} label: {
			HStack {
				if hasIcon {
					Image(systemName: icon)
						.padding(12)
						.clipShape(Circle())
						.overlay(
							Circle()
								.stroke(style: StrokeStyle(lineWidth: 1))
						)
				}

				Text(title)
					.font(.system(size: 18, weight: .medium))
				Spacer()
				Image(systemName: "arrow.right")
			}
			.foregroundStyle(Color("MainColor"))
			
		}
    }
}

#Preview {
	OverviewSettingsButton(
		title: "Title",
		icon: "key",
		action: {},
		hasIcon: true
	)
}
