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
		.onTapGesture {
			onTap()
		}
		.padding()
		.cornerRadius(12)
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color("Outline"), lineWidth: 1)
		)
		.frame(maxWidth: 400 )
		
	}
}

#Preview {
	UserMenuSheetNavigationItem(onTap: {})
}
