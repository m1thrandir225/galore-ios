//
//  HomeView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import SwiftUI

struct HomeScreen: View {
	@StateObject var router: Router<TabRoutes>
	
	@StateObject var viewModel: HomeViewModel = HomeViewModel()
	
	let columns = [GridItem(.fixed(180)), GridItem(.fixed(180))]
	
	
	var body: some View {
		ScrollView {
			if viewModel.isLoading {
				ProgressView()
			} else {
				if viewModel.featuredCocktails.count > 0 {
					CocktailCarousel(
						items: viewModel.featuredCocktails,
						isCarouselShowcase: true, navigateToSection: {},
						onCardPress: { id in
							router.routeTo(.cocktailDetails(id: id))
						}
					)
				}
				if viewModel.userRecommendedCocktails.count > 0 {
					ForEach(viewModel.userRecommendedCocktails, id: \.category.id) { item in
						CocktailCarousel(
							items: item.cocktails,
							title: item.category.name,
							isCarouselShowcase: false,
							navigateToSection: {},
							onCardPress: { id in
								router.routeTo(.cocktailDetails(id: id))
							}
						)
					}
				}
			}
			
		}
		.background(Color(.background))
		.onAppear {
			Task {
				await viewModel.getCocktails()
				await viewModel.getFeaturedCocktails()
				await viewModel.getCocktailsForUserCategories()
			}
		}
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	HomeScreen(router: router)
}
