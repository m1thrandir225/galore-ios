//
//  UserSheetButtonStyle.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 14.11.24.
//
import SwiftUI

struct UserSheetButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.fontWeight(.medium)
			.foregroundStyle(Color("MainColor"))
			.padding()
			.cornerRadius(12)
			.opacity(configuration.isPressed ? 0.3 : 1)
			.animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
			.overlay(
				RoundedRectangle(cornerRadius: 12)
					.stroke(Color("Outline"), lineWidth: .init(1))
					.scaleEffect(configuration.isPressed ? 1.1 : 1)
					.animation(.easeInOut(duration: 0.2), value: configuration.isPressed)

			)
			.scaleEffect(configuration.isPressed ? 1.1 : 1)
		

	}
	
}
