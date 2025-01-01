//
//  GenerateScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI
import Lottie

struct GenerateScreen :  View {
	@StateObject  var router: Router<TabRoutes>
	
	
	var body: some View {
		VStack(alignment: .leading) {
			VStack(alignment: .center, spacing: 24) {
				Text("Generate Unique Cocktails")
					.font(.system(size: 26, weight: .bold))
					.multilineTextAlignment(.center)
					.foregroundStyle(Color("OnMainContainer"))
				Text("Your Flavours, Your Cocktail")
					.font(.system(size: 20, weight: .medium))
					.multilineTextAlignment(.center)
					.foregroundStyle(Color("OnMainContainer"))
				LottieView(animation: .named("generateLottie"))
					.playing(loopMode: .loop)
					.scaledToFill()
					.frame(width: 250, height: 150)
				
				Button {
					router.routeTo(.generateSelectFlavours)
				} label: {
					Text("Get Started")
						.frame(maxWidth: .infinity)
				}.buttonStyle(MainButtonStyle(isDisabled: false))
			}
			.padding(24)
			.background(Color("MainContainer"))
			.clipShape(RoundedRectangle(cornerRadius: 16))
			.overlay(
				RoundedRectangle(cornerRadius: 16)
					.stroke(Color("OnMainContainer"), lineWidth: 2)
			)
			
			
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding(24)
		.background(Color("Background"))
		
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	GenerateScreen(router: router)
}
