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
	
	var body: some View {
		ScrollView (.vertical, showsIndicators: false) {
			switch(viewModel.isLoading, viewModel.errorMessage) {
			case(true, _):
				ProgressView()
			case (_, .some(let error)):
				Text(error)
			case (false, nil):
				contentView
			default:
				EmptyView()
			}
		}
		.background(Color("Background"))
		.task {
			await viewModel.loadData()
		}
	}
	
	private var contentView: some View {
		VStack {
			CocktailCarousel(
				items: viewModel.featuredCocktails,
				isCarouselShowcase: true,
				navigateToSection: {},
				onCardPress: { id in
					router.routeTo(.cocktailDetails(id: id))
				}
			)
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

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	HomeScreen(router: router)
}
