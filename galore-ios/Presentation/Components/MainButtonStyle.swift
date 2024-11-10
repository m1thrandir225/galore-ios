//
//  MainButtonStyle.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 7.11.24.
//
import SwiftUI

struct MainButtonStyle: ButtonStyle {
	var isDisabled: Bool
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding(12)
			.foregroundStyle(.white)
			.background(configuration.isPressed ? Color("MainColor").opacity(0.8) : (isDisabled ? Color("Teritary").opacity(0.5) : Color("MainColor")))
			.cornerRadius(24)
			.opacity(isDisabled ? 0.5 : 1)
	}
}

