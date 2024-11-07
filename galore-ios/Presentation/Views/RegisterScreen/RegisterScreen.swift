//
//  LoginScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//

import SwiftUI
import Lottie

enum RegisterStep {
	case info
	case personalization
	
	var next: RegisterStep? {
		switch self {
		case .info: return .personalization
		case .personalization: return nil
		}
	}
	
	var previous: RegisterStep? {
		switch self {
		case .info: return nil
		case .personalization: return .info
		}
	}
}

struct RegisterScreen: View {	
	@State var currentStep: RegisterStep = .info
	
	@StateObject var router: Router<Routes>
	@StateObject private var viewModel = RegisterViewModel()
	
	init(router: Router<Routes>) {
		_router = StateObject(wrappedValue: router)
	}
	
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
			
			
			switch currentStep {
			case .info:
				RegisterInfoStep(name: $viewModel.name, email: $viewModel.email, password: $viewModel.password)
					.transition(.slide.combined(with: .blurReplace))
			case .personalization:
				RegisterPersonalizationStep(birthday: $viewModel.birthday, avatarURL: $viewModel.avatarURL)
					.transition(.slide.combined(with: .blurReplace))
			}
			
			
			VStack(alignment: .center, spacing: 24){
				HStack {
					if let previous = currentStep.previous {
						Button(action: {
							withAnimation {
								currentStep = previous
							}

						}) {
							Text("Go Back")
								.font(.headline)
								.padding(.all, 6)
								.frame(maxWidth: .infinity)
						}
						.frame(maxWidth: 120)
						.buttonStyle(MainButtonStyle(isDisabled: false))
					}
					
					Button(action: {
						withAnimation {
							if let nextStep = currentStep.next {
								currentStep = nextStep
							} else {
								viewModel.register()
							}
						}
						
					}) {
						Text("Continue")
							.font(.headline)
							.padding(.all, 6)
							.frame(maxWidth: .infinity)
					}.disabled(!viewModel.canContinue(step: currentStep))
					.buttonStyle(MainButtonStyle(isDisabled: !viewModel.canContinue(step: currentStep)))
				}
				.padding([.leading, .trailing], 24)
				
					
					
				
				HStack {
					Text("Already have an account?")
					Button(action: {
						withAnimation {
							router.replace(.login)
						}
	
					}) {
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
	@Previewable @State  var authRoute: Routes? = nil
	let router = Router<Routes>(isPresented: Binding(projectedValue: $authRoute))
	
	RegisterScreen(router: router)
}
