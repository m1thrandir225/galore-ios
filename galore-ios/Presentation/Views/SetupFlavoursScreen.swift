//
//  SetupFlavoursScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import SwiftUI

struct SetupFlavoursScreen : View {
	@StateObject var router: Router<OnboardingRoutes>
	@StateObject var viewModel: SetupFlavoursViewModel = SetupFlavoursViewModel()
	
	let columns = [GridItem(.fixed(190)), GridItem(.fixed(190))]
	
	var body: some View {
		VStack (alignment: .center, spacing: 24) {
			Logo()
			Spacer()
			Text("Choose your favourite \n flavours ")
				.font(.system(size: 32, weight: .semibold))
				.multilineTextAlignment(.center)
				.frame(width: 400)
			if viewModel.isLoading {
				ProgressView()
					.accentColor(Color("Main"))
			} else {
				if let flavours = viewModel.flavours {
					LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
						ForEach(flavours, id: \.id) { flavour in
							Button {
								let generator = UIImpactFeedbackGenerator(style: .heavy)
								viewModel.addOrRemoveFlavourToLiked(flavour.id)
								generator.impactOccurred()
								
							} label: {
								HStack {
									Image(systemName: viewModel.isFlavourLiked(flavour.id) ? "minus" : "plus" )
									Text(flavour.name)
										.font(.system(size: 18, weight: .semibold))
										
										
								}
								.foregroundStyle(viewModel.isFlavourLiked(flavour.id) ? Color("OnMain") : Color("MainColor"))
								
								.frame(minWidth: 0, maxWidth: .infinity)
								
								.padding()
								.background(viewModel.isFlavourLiked(flavour.id) ? Color("MainColor") : Color("Background"))
								.clipShape(RoundedRectangle(cornerRadius: 16))
								.overlay(
									RoundedRectangle(cornerRadius: 16)
										.stroke(viewModel.isFlavourLiked(flavour.id) ? Color("Secondary") : Color("MainColor").opacity(0.5), lineWidth: 2)
								)
								.transition(.scale.combined(with: .opacity))
								.animation(.spring(duration: 0.3, bounce: 0.5, blendDuration: 0), value: viewModel.isFlavourLiked(flavour.id))
							}.disabled(viewModel.isLoading)
						}
					}
				}
				
				
				
			}
			
			Spacer()
			Button {
				Task {
					try await viewModel.submitLikedFlavours {
						router.routeTo(.allDone)
					}
				}
			} label: {
				ZStack {
					if viewModel.isSubmitting {
						// Show loading spinner
						ProgressView()
							.progressViewStyle(CircularProgressViewStyle(tint: (Color("OnMain"))))
							.foregroundColor(Color("OnMain"))
						
						
					} else {
						// Show the button label
						Text("Continue")
							.font(.system(size: 18, weight: .semibold))
					}
				}
				.frame(maxWidth: .infinity) // Keeps the button width consistent
				.padding()
				.foregroundStyle(Color("OnMain"))
				.background(Color("MainColor"))
				.clipShape(RoundedRectangle(cornerRadius: 16))
			}
			.padding(24)
			.disabled(viewModel.isSubmitting)
			
			
		}
		.background(Color("Background"))
		.task {
			await viewModel.loadData()
		}
	}
}

#Preview {
	@Previewable @State  var route: OnboardingRoutes? = nil
	let router = Router<OnboardingRoutes>(isPresented: Binding(projectedValue: $route))
	
	let flavours = [
		Flavour(id: "1", name: "Sweet", createdAt: "2024-12-01T10:00:00Z"),
		Flavour(id: "2", name: "Sour", createdAt: "2024-12-02T12:30:00Z"),
		Flavour(id: "3", name: "Bitter", createdAt: "2024-12-03T15:45:00Z"),
		Flavour(id: "4", name: "Herbaceous", createdAt: "2024-12-04T18:20:00Z"),
		Flavour(id: "5", name: "Smokey", createdAt: "2024-12-05T21:10:00Z"),
		Flavour(id: "6", name: "Savoury", createdAt: "2024-12-05T21:10:00Z"),
		Flavour(id: "7", name: "Spicy", createdAt: "2024-12-05T21:10:00Z"),
		Flavour(id: "8", name: "Fruity", createdAt: "2024-12-05T21:10:00Z")
	]
	
	
	SetupFlavoursScreen(router: router)
}
