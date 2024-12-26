//
//  ForgotPasswordEnterEmailStep.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//

import SwiftUI

struct ForgotPasswordEnterEmailStep: View {
	@Binding var email: String
	
	var onNext: () -> Void
	
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
			
			Button {
				onNext()
			} label: {
				Text("Send OTP")
					.font(.system(size: 16, weight: .semibold))
					.frame(maxWidth: .infinity)
					.padding()
					.background(Color("MainColor"))
					.foregroundStyle(Color("OnMain"))
					.clipShape(RoundedRectangle(cornerRadius: 16))
					
			}
		}.transition(.slide.combined(with: .blurReplace))
    }
}

#Preview {
	@Previewable @State var email: String = ""
	ForgotPasswordEnterEmailStep(email: $email) {}
}
