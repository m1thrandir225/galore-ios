//
//  PasswordField.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 3.12.24.
//
import SwiftUI

struct PasswordField : View {
	@Binding var text: String
	@State var isShowingPassword: Bool = false
	var body: some View {
		HStack {
			if isShowingPassword {
				TextField(
					"Password",
					text: $text
				)
				.padding(.all, 20)
				.frame(height: 60)
				.overlay(
					RoundedRectangle(cornerRadius: 8)
						.stroke(Color("Outline"), lineWidth: 1.5)
				)
				.textContentType(.password)
			} else {
				SecureField(
					"Password",
					text: $text
				).padding(.all, 20)
					.frame(height: 60)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color("Outline"), lineWidth: 1.5)
					)
				
				
			}
			if !text.isEmpty {
				Button {
					isShowingPassword.toggle()
				} label: {
					if isShowingPassword {
						Image(systemName: "eye.slash")
							.transition(.opacity.combined(with: .symbolEffect))
							.padding(.all, 2)
					} else {
						Image(systemName: "eye")
							.transition(.opacity.combined(with: .symbolEffect))
							.padding(.all, 2)
					}
				}
				
				.buttonStyle(.borderedProminent)
				.buttonBorderShape(.circle)
				.transition(.opacity.combined(with: .scale))
				.tint(Color(.main))
			}
			
		}
		.animation(.bouncy, value: text.isEmpty)
		
	}
}

#Preview {
	@Previewable @State var text: String = ""
	PasswordField(text: $text)
}
