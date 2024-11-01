//
//  RegisterScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//


import SwiftUI
import Lottie

struct LoginScreen: View {
	@State private var email: String = ""
	@State private var password: String = ""
	
	var body: some View {
		VStack {
			VStack(alignment: .center, spacing: 4) {
				Text("galore")
					.font(.system(size: 46))
					.fontWeight(.heavy)
					.foregroundColor(Color("MainColor"))
				
				LottieView(animation: .named("loginLottie"))
					.playing(loopMode: .loop)
					.scaledToFill()
					.frame(height: 200)
			}
//			Spacer(minLength: 32.0)
			VStack(alignment: .leading, spacing: 24) {
				Text("Login")
					.font(.largeTitle)
				TextField(
					"",
					text: $email,
					prompt: Text("Email").foregroundStyle(.onBackground)
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray, lineWidth: 1.5)
					)
				.keyboardType(.emailAddress)
				
				SecureField(
					"",
					text: $password,
					prompt: Text("Password: ").foregroundStyle(.onBackground)
				)
					.padding(.all, 20)
						.overlay(
							RoundedRectangle(cornerRadius: 8)
								.stroke(Color.gray, lineWidth: 1.5)
						)
			}
			.padding(.all, 20)
			
			Spacer(minLength: 64.0)
			
			VStack(alignment: .center, spacing: 24){
				Button(action: {
					print("Hello World")
				}) {
					Text("Continue")
						.font(.headline)
						.foregroundColor(.white)
						.padding(.all, 14)
						.frame(maxWidth: .infinity)
						.background(Color("MainColor"))
						.cornerRadius(24)
				}.padding([.leading, .trailing], 24)
				
				HStack {
					Text("Don't have an account?")
					NavigationLink(destination: RegisterScreen()) {
						Text("Register")
							.foregroundColor(Color("MainColor"))
							.fontWeight(.bold)
					}
				}
			}
			
			Spacer()

			
		}.background(Color("Background"))
	
	}
}

#Preview {
	LoginScreen()
}
