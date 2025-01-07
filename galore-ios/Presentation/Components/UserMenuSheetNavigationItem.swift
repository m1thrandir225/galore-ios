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
							.frame(width: 24, height: 24)
							.foregroundStyle(Color("MainColor"))
					}
					if let text {
						Text(text)
							.font(.system(size: 16, weight: .medium))
							.foregroundStyle(Color("MainColor"))
							
					}
					Spacer()
					Image(systemName: "chevron.right")
						.foregroundStyle(Color("Secondary"))
				}
			}
		}
		.frame(maxWidth: .infinity)
		.background(Color("MainContainer"))
		.clipShape(RoundedRectangle(cornerRadius: 16))
		.buttonStyle(UserSheetButtonStyle())
		
	}
}

#Preview {
	UserMenuSheetNavigationItem(iconName: "person.crop.circle.fill", text: "Profile", onTap: {})
}
