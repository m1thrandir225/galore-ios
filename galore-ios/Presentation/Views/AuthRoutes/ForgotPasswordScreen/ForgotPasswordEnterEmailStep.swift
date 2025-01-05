//
//  ForgotPasswordEnterEmailStep.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//

import SwiftUI

struct ForgotPasswordEnterEmailStep: View {
	@Binding var email: String
	
	@Binding var isLoading: Bool
	
	func isEmailValid() -> Bool {
		let emailTest = NSPredicate(format: "SELF MATCHES %@", "^\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}$")
		return emailTest.evaluate(with: email)
	}

	var onNext: () -> Void
	
	var emailPrompt: String {
		if isEmailValid() {
			return ""
		} else {
			return "Please enter a valid email address"
		}
	}
	
	
    var body: some View {
		VStack (alignment: .leading, spacing: 16) {
			Text("Please enter your email address:")
				.font(.system(size: 14, weight: .semibold))
				.foregroundStyle(Color("Secondary"))
			TextField(
				"Email",
				text: $email
			).padding(.all, 20)
				.overlay(
					RoundedRectangle(cornerRadius: 16)
						.stroke(Color("Outline"), lineWidth: 1.5)
				)
			.keyboardType(.emailAddress)
			.autocapitalization(.none)
			
			if !email.isEmpty {
				Text(emailPrompt).font(.caption).foregroundStyle(Color("Error"))
					.fontWeight(.semibold).transition(.scale)
			}
			
			Button {
				onNext()
			} label: {
				ZStack {
					if isLoading {
						// Show loading spinner
						ProgressView()
							.progressViewStyle(CircularProgressViewStyle(tint: (Color("OnMain"))))
							.foregroundColor(Color("OnMain"))
						
						
					} else {
						Text("Send OTP")
							.font(.system(size: 18, weight: .semibold))
					}
				}
				.frame(maxWidth: .infinity)
			}
			.disabled(isLoading || !isEmailValid())
			.buttonStyle(
				MainButtonStyle(isDisabled: isLoading || !isEmailValid())
			)
		}.transition(.slide.combined(with: .blurReplace))
    }
}

#Preview {
	@Previewable @State var email: String = ""
	@Previewable @State var isLoading: Bool = false
	ForgotPasswordEnterEmailStep(email: $email, isLoading: $isLoading) {}
}
