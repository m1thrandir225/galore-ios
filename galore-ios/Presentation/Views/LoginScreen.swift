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
	@State private var showPassword: Bool = false
	
	@StateObject var router: Router<AuthRoutes>
	@StateObject private var viewModel = LoginViewModel()
	
	init(router: Router<AuthRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
	
	var body: some View {
		ScrollView {
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
					"Email",
					text: $viewModel.email
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color("Outline"), lineWidth: 1.5)
					)
				.keyboardType(.emailAddress)
				.autocapitalization(.none)
				
				PasswordField(text: $viewModel.password)
				
				
				if let errorMessage = viewModel.errorMessage {
					Text(errorMessage)
						.foregroundStyle(.red)
				}
				Button {
					router.routeTo(.forgotPassword)
				} label: {
					Text("Forgot your password?")
						.foregroundStyle(Color("MainColor"))
				}
			}
			.padding(.all, 20)
			
			Spacer(minLength: 64.0)
			
			VStack(alignment: .center, spacing: 24){
				Button(action: {
					Task {
						await viewModel.login()
					}
				}) {
					if viewModel.isLoading {
						ProgressView()
							.tint(Color(.onMain))
							.frame(maxWidth: .infinity)
					} else {
						Text("Continue")
							.font(.headline)
							.padding(.all, 6)
							.frame(maxWidth: .infinity)
					}
					
				}.padding([.leading, .trailing], 24)
					.disabled(!viewModel.canContinue())
					.buttonStyle(MainButtonStyle(isDisabled: !viewModel.canContinue()))
				
				HStack {
					Text("Don't have an account?")
					
					Button(action: {
						router.replace(.register)
					}) {
						Text("Register")
							.foregroundColor(Color("MainColor"))
							.fontWeight(.bold)
					}
				}
			}
			
			Spacer()
		}.navigationTitle("").navigationBarTitleDisplayMode(.inline).navigationBarBackButtonHidden(true).background(Color("Background"))
	}
}

#Preview {
	@Previewable @State  var authRoute: AuthRoutes? = nil
	let router = Router<AuthRoutes>(isPresented: Binding(projectedValue: $authRoute))
	LoginScreen(router: router)
}
