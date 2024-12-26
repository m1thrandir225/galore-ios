//
//  ForgotPasswordEnterCodeStep.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//

import SwiftUI

struct ForgotPasswordEnterCodeStep: View {
	@Binding var code: String
	
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
				Text("Verify")
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
	@Previewable @State var code: String = ""
	ForgotPasswordEnterCodeStep(code: $code) {}
}
