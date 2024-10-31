//
//  LoginScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//

import SwiftUI
import Lottie

struct LoginScreen: View {
	@State var email: String = "";
	@State var password: String = "";
	
	var body: some View {
		VStack {
			VStack(alignment: .center, spacing: -48) {
				Text("galore")
					.font(.system(size: 46))
					.fontWeight(.heavy)
					.foregroundColor(Color("MainColor"))
				
				LottieView(animation: .named("loginLottie"))
					.playing(loopMode: .loop)
					.scaledToFit()
					.frame(height: 200)
			}
			Spacer(minLength: 64.0)
			VStack(alignment: .leading, spacing: 24) {
				TextField(
					"Email: ",
					text: $email
				).padding(.all, 12)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray, lineWidth: 1.5)
					)
				.keyboardType(.emailAddress)
				
				SecureField("Password: ", text: $password)
					.padding(.all, 12)
						.overlay(
							RoundedRectangle(cornerRadius: 8)
								.stroke(Color.gray, lineWidth: 1.5)
						)
				NavigationLink(destination: ForgotPasswordScreen()) {
					Text("Forgot Password ?").foregroundStyle(.secondary)
				}
			}
			.padding(.all, 20)
			Spacer()
			Button(action: {
				print("Hello World")
			}) {
				Text("Sign In")
					.font(.headline)
					.foregroundColor(.white)
					.padding()
					.frame(maxWidth: 200)
					.background(Color("MainColor"))
					.cornerRadius(12)
			}
			Spacer()

			
		}.background(.quinary)
	
    }
}

#Preview {
    LoginScreen()
}
