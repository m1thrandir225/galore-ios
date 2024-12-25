//
//  LibraryScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI

struct LibraryScreen: View {
	@StateObject  var router: Router<TabRoutes>
	
	@StateObject var viewModel: LibraryViewModel = LibraryViewModel()
	
	init(router: Router<TabRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
	
	var body: some View {
		ScrollView {
			if let userLikedCocktails = viewModel.userLikedCocktails {
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
		.refreshable {
			Task {
				await viewModel.loadData()
			}
		}
		.background(Color("Background"))
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
