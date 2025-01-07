//
//  GenerateScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI
import Lottie

enum GenerateScreenCurrentView {
	case generate
	case viewStatus
}

struct GenerateScreen :  View {
	@StateObject var router: Router<TabRoutes>
	@StateObject var viewModel: GenerateViewModel = GenerateViewModel()
	
	@State var currentView: GenerateScreenCurrentView
	let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

	
	init(router: Router<TabRoutes>, currentView: GenerateScreenCurrentView = .generate) {
		_router = StateObject(wrappedValue: router)
		self.currentView = currentView
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			headerButtons
			
			Spacer()
			switch currentView {
			case .generate:
					generateView
		
			case .viewStatus:
				viewStatus
			}
			
			Spacer()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding(24)
		.background(Color("Background"))
		
	}
	
	private var headerButtons: some View {
		HStack(alignment: .center, spacing: 12) {
			Button {
				currentView = .generate
			} label: {
				Text("Generate")
					.padding()
					.font(.system(size: 16, weight: currentView == .generate ? .bold : .medium))
					.foregroundColor(currentView == .generate ? Color("OnSecondaryContainer") : Color("OnBackground"))
					.background(currentView == .generate ?  Color("SecondaryContainer") : Color("Background"))
					.clipShape(RoundedRectangle(cornerRadius: 16))
					
			}

			Button {
				currentView = .viewStatus
			} label: {
				Text("View Status")
					.padding()
					.font(.system(size: 16, weight: currentView == .viewStatus ? .bold : .medium))

					.foregroundColor(currentView == .viewStatus ? Color("OnSecondaryContainer") : Color("OnBackground"))
					.background(currentView == .viewStatus ?  Color("SecondaryContainer") : Color("Background"))
					.clipShape(RoundedRectangle(cornerRadius: 16))
			}
		}.animation(.bouncy, value: currentView)
	}
	
	private var generateView: some View {
		VStack(alignment: .center, spacing: 24) {
			Text("Generate Unique Cocktails")
				.font(.system(size: 18, weight: .bold))
				.multilineTextAlignment(.center)
				.foregroundStyle(Color("OnMainContainer"))
			Text("Your Flavours, Your Cocktail")
				.font(.system(size: 14, weight: .medium))
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
					.font(.system(size: 18, weight: .bold))
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
	
	private var viewStatus: some View {
		VStack(alignment: .leading, spacing: 16) {
			SectionTitle(text: "Generation Status", fontSize: 32)
			if let generateRequests = viewModel.generateRequests {
				if generateRequests.count != 0 {
					Text("Here are your current cocktail generation requests.")
						.font(.system(size: 14, weight: .medium))
						.foregroundStyle(Color("Secondary"))
				} else {
					Text("You don't have any active generation requests. To get started press the Generate tab.")
						.font(.system(size: 14, weight: .medium))
						.foregroundStyle(Color("Secondary"))
				}
			} else {
				Text("You don't have any active generation requests. To get started press the Generate tab.")
					.font(.system(size: 14, weight: .medium))
					.foregroundStyle(Color("Secondary"))
			}
			
			GenerateStatusView(
				isLoading: $viewModel.isLoading,
				requests: $viewModel.generateRequests
			)
			Spacer()
			
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.onAppear {
			Task {
				await viewModel.loadData()
			}
		}
		.onReceive(timer) {time in
			Task {
				await viewModel.refetchData()
			}
		}
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	GenerateScreen(router: router, currentView: .generate)
}
