//
//  LoginScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//

import SwiftUI
import Lottie

struct RegisterScreen: View {
	@State var name: String = ""
	@State var email: String = "";
	@State var password: String = "";
	
	var body: some View {
		VStack {
			VStack(alignment: .center, spacing: 12) {
				Text("galore")
					.font(.system(size: 46))
					.fontWeight(.heavy)
					.foregroundColor(Color("MainColor"))
				
				LottieView(animation: .named("registerLottie"))
					.playing(loopMode: .loop)
					.scaledToFill()
					.frame(height: 150)
			}
			VStack(alignment: .leading, spacing: 24) {
				Text("Register")
					.font(.largeTitle)
				TextField(
					"",
					text: $name,
					prompt: Text("Your Name").foregroundStyle(.onBackground)
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray, lineWidth: 1.5)
					)
					.keyboardType(.default)

				TextField(
					"",
					text: $email,
					prompt: Text("Your Email").foregroundStyle(.onBackground)
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray, lineWidth: 1.5)
					)
				.keyboardType(.emailAddress)
				
				SecureField(
					"",
					text: $password,
					prompt: Text("Your Password").foregroundStyle(.onBackground)
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
					Text("Already have an account?")
					NavigationLink(destination: LoginScreen()) {
						Text("Login")
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
	RegisterScreen()
}
