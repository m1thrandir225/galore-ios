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
	
	@StateObject var router: Router<Routes>
	@StateObject private var viewModel = LoginViewModel(authenticationRepository: AuthenticationRepositoryImpl())
	
	init(router: Router<Routes>) {
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
					"",
					text: $viewModel.email,
					prompt: Text("Email").foregroundStyle(.onBackground)
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray, lineWidth: 1.5)
					)
				.keyboardType(.emailAddress)
				.autocapitalization(.none)
				
				SecureField(
					"",
					text: $viewModel.password,
					prompt: Text("Password: ").foregroundStyle(.onBackground)
				)
					.padding(.all, 20)
						.overlay(
							RoundedRectangle(cornerRadius: 8)
								.stroke(Color.gray, lineWidth: 1.5)
						)
				if let errorMessage = viewModel.errorMessage {
					Text(errorMessage)
						.foregroundStyle(.red)
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
					Text("Continue")
						.font(.headline)
						.foregroundColor(Color("OnMain"))
						.padding(.all, 14)
						.frame(maxWidth: .infinity)
						.background(Color("MainColor"))
						.cornerRadius(24)
				}.padding([.leading, .trailing], 24)
				
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
	@Previewable @State  var authRoute: Routes? = nil
	let router = Router<Routes>(isPresented: Binding(projectedValue: $authRoute))
	LoginScreen(router: router)
}
