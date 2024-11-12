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
	
	@FocusState private var focus: Field?
	
	private enum Field: Int, Hashable, CaseIterable {
		case email
		case password
	}
	
	private func dismissKeyboard() {
		self.focus = nil
	}
	
	private func nextField() {
		guard let currentIndex = focus,
			  let lastIndex = Field.allCases.last?.rawValue else { return }
		
		let index = min(currentIndex.rawValue + 1, lastIndex)
		self.focus = Field(rawValue: index)
	}
	private func previousField() {
		guard let currentIndex = focus,
			  let firstIndex = Field.allCases.first?.rawValue else { return }
		
		let index = max(currentIndex.rawValue - 1, firstIndex)
		self.focus = Field(rawValue: index)
	}
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
					"Email",
					text: $viewModel.email
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color("Outline"), lineWidth: 1.5)
					)
				.keyboardType(.emailAddress)
				.autocapitalization(.none)
				.focused($focus, equals: Field.email)
				
				SecureField(
					"Password",
					text: $viewModel.password
				)
					.focused($focus, equals: Field.password)
					.padding(.all, 20)
						.overlay(
							RoundedRectangle(cornerRadius: 8)
								.stroke(Color("Outline"), lineWidth: 1.5)
						)
				if let errorMessage = viewModel.errorMessage {
					Text(errorMessage)
						.foregroundStyle(.red)
				}
			}
			.padding(.all, 20)
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Button {
						dismissKeyboard()
					} label: {
						Image(systemName: "xmark")
					}
					
					Spacer()
					
					Button {
						previousField()
					} label: {
						Image(systemName: "chevron.up")
					}
					
					Button {
						nextField()
					} label: {
						Image(systemName: "chevron.down")
					}
				}
			}
			
			Spacer(minLength: 64.0)
			
			VStack(alignment: .center, spacing: 24){
				Button(action: {
					Task {
						await viewModel.login()
					}
				}) {
					Text("Continue")
						.font(.headline)
						.padding(.all, 6)
						.frame(maxWidth: .infinity)
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
	@Previewable @State  var authRoute: Routes? = nil
	let router = Router<Routes>(isPresented: Binding(projectedValue: $authRoute))
	LoginScreen(router: router)
}
