//
//  ForgotPasswordEnterCodeStep.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//

import SwiftUI

struct ForgotPasswordEnterCodeStep: View {
	@Binding var code: String
	@Binding var isLoading: Bool

	
	var onNext: () -> Void
	
	var body: some View {
		VStack (alignment: .leading, spacing: 16) {
			Text("Please enter the code you received in your email: ")
				.font(.system(size: 14, weight: .semibold))
				.foregroundStyle(Color("Secondary"))
			TextField(
				"Code",
				text: $code
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
				ZStack {
					if isLoading {
						// Show loading spinner
						ProgressView()
							.progressViewStyle(CircularProgressViewStyle(tint: (Color("OnMain"))))
							.foregroundColor(Color("OnMain"))
						
						
					} else {
						Text("Verify")
							.font(.system(size: 18, weight: .semibold))
					}
				}
				.frame(maxWidth: .infinity)
				.padding()
				.foregroundStyle(Color("OnMain"))
				.background(Color("MainColor"))
				.clipShape(RoundedRectangle(cornerRadius: 16))
			}
			.disabled(isLoading)
		}.transition(.slide.combined(with: .blurReplace))
	}
}

#Preview {
	@Previewable @State var code: String = ""
	@Previewable @State var isLoading: Bool = false
	ForgotPasswordEnterCodeStep(code: $code, isLoading: $isLoading) {}
}
