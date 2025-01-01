//
//  LibraryScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI
import Lottie

struct LibraryScreen: View {
	@StateObject  var router: Router<TabRoutes>
	
	@StateObject var viewModel: LibraryViewModel = LibraryViewModel()
	
	init(router: Router<TabRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
	
	var body: some View {
		VStack (alignment: .leading, spacing: 24) {
			if let userLikedCocktails = viewModel.userLikedCocktails, let userCreatedCocktails = viewModel.userCreatedCocktails {
				if !userLikedCocktails.isEmpty || !userCreatedCocktails.isEmpty {
					ScrollView(.vertical, showsIndicators: false){
						HStack(alignment: .center ) {
							Text("Your Library")
								.font(.system(size: 42, weight: .bold))
								.foregroundStyle(Color("MainColor"))
								.multilineTextAlignment(.leading)
							
							Spacer()
						}
						.frame(maxWidth: .infinity)
						.padding(24)
						
						if !userLikedCocktails.isEmpty {
							VStack(alignment: .leading) {
								CocktailCarousel(
									items: userLikedCocktails,
									title: "Liked Cocktails",
									isCarouselShowcase: false,
									navigateToSection: {
										router.routeTo(.cocktailSection(CocktailSectionArgs(cocktails: userLikedCocktails, title: "Your Liked Cocktails")))
									},
									onCardPress: { id in
										router.routeTo(
											.cocktailDetails(
												CocktailDetailsArgs(
													id: id,
													rootSentFrom: TabRoutes.library
												)
											)
										)
										
									})
							}
							
							
						}
					}
				} else {
					VStack(alignment: .center ,spacing: 24) {
						LottieView(animation: .named("emptyLibrary"))
							.playing(loopMode: .playOnce)
							.scaledToFill()
							.frame(height: 200)
						VStack (alignment: .center, spacing: 12) {
							Text("This is your library.")
								.font(.system(size: 24, weight: .semibold))
								.multilineTextAlignment(.center)
								.foregroundStyle(Color("OnSecondaryContainer"))
							Text("To get started like a cocktail or generate your own concoction.")
								.font(.system(size: 18, weight: .regular))
								.foregroundStyle(Color("OnSecondaryContainer"))
								.frame(width: 300)
								.multilineTextAlignment(.center)
						}
					}
					.padding()
					.background(Color("SecondaryContainer"))
					.clipShape(RoundedRectangle(cornerRadius: 16))
					.overlay(
						RoundedRectangle(cornerRadius: 16)
							.stroke(Color("Secondary"), lineWidth: 1)
					)
				}
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color("Background"))
		
		.refreshable {
			Task {
				await viewModel.loadData()
			}
		}
		.task {
			await viewModel.loadData()
		}
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	LibraryScreen(router: router)
}
