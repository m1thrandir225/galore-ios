//
//  UserMenuSheetNavigationItem.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 13.11.24.
//
import SwiftUI

struct UserMenuSheetNavigationItem : View {
	@State var iconName: String? = nil
	@State var text: String? = nil
	var onTap: () -> Void
	var body: some View {
		Button {
			onTap()
		} label: {
			HStack {
				HStack(alignment: .center) {
					if let iconName {
						Image(systemName: iconName)
							.resizable()
							.scaledToFit()
							.frame(width: 32, height: 32)
							.foregroundStyle(Color("Secondary"))
					}
					if let text {
						Text(text)
							.fontWeight(.medium)
						
							.foregroundStyle(Color("MainColor"))
							
					}
					Spacer()
					Image(systemName: "chevron.right")
						.foregroundStyle(Color("Secondary"))
				}
			}
		}
		.frame(maxWidth: 400)
		.buttonStyle(UserSheetButtonStyle())
	}
}

#Preview {
	UserMenuSheetNavigationItem(iconName: "person.crop.circle.fill", text: "Profile", onTap: {})
}
