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
					Text("Get ready to become your own mixology master")
						.font(.system(size: 16, weight: .medium))
						.multilineTextAlignment(.center)
				}
				
				Button {
					Task {
						try await viewModel.recheck()
					}
					
				} label: {
					ZStack {
						if viewModel.isLoading {
							// Show loading spinner
							ProgressView()
								.progressViewStyle(CircularProgressViewStyle(tint: (Color("OnMain"))))
								.foregroundColor(Color("OnMain"))
						} else {
							// Show the button label
							Text("Finish Setup")
								.font(.system(size: 18, weight: .semibold))
						}
					}
					.frame(maxWidth: .infinity) // Keeps the button width consistent
					.padding()
					.foregroundStyle(Color("OnMain"))
					.background(Color("MainColor"))
					.clipShape(RoundedRectangle(cornerRadius: 16))
				}
				
				if let errorMessage = viewModel.errorMessage {
					Text(errorMessage)
						.font(.system(size: 16, weight: .semibold))
						.foregroundStyle(Color("Error"))
				}
			}
			
		}
		.padding(24)
		.background(Color("Background"))
	}
}

#Preview {
	@Previewable @State  var route: OnboardingRoutes? = nil
	let router = Router<OnboardingRoutes>(isPresented: Binding(projectedValue: $route))
	AllSetScreen(router: router)
}

