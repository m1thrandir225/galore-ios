//
//  AllSetScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import SwiftUI
import Lottie

struct AllSetScreen: View {
	@StateObject var router: Router<OnboardingRoutes>
	
	@StateObject var viewModel: AllSetViewModel = AllSetViewModel()
	
	var body: some View {
		VStack  {
			Logo()
			Spacer()
			LottieView(animation: .named("allsetLottie"))
				.playing(loopMode: .loop)
				.scaledToFill()
			
			Spacer()
			VStack (spacing: 50){
				VStack (spacing: 12){
					Text("You’re all set!")
						.font(.system(size: 36, weight: .bold))
						.foregroundStyle(Color("OnBackground"))
					Text("Get ready to become your own mixology master")
						.font(.system(size: 16, weight: .medium))
						.foregroundStyle(Color("OnBackground"))
						.multilineTextAlignment(.center)
						
				}
				
				Button {
					Task {
						try await viewModel.recheck()
					}
					
				} label: {
					ZStack {
						if viewModel.isLoading {
							ProgressView()
								.progressViewStyle(CircularProgressViewStyle(tint: (Color("OnTeritaryContainer"))))
						} else {
							Text("Finish Setup")
								.font(.system(size: 18, weight: .semibold))
						}
					}
					.frame(maxWidth: .infinity)
				}
				.disabled(viewModel.isLoading)
				.buttonStyle(
					MainButtonStyle(isDisabled: viewModel.isLoading)
				)
				
				if let errorMessage = viewModel.errorMessage {
					ErrorMessage(text: errorMessage)
						.animation(.smooth, value: viewModel.errorMessage)
				}
			}
			
		}
		.navigationBarBackButtonHidden()
		.padding(24)
		.background(Color("Background"))
	}
}

#Preview {
	@Previewable @State  var route: OnboardingRoutes? = nil
	let router = Router<OnboardingRoutes>(isPresented: Binding(projectedValue: $route))
	AllSetScreen(router: router)
}

