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
		.refreshable {
			Task {
				await viewModel.getHomescreen()
			}
		}
	}
	
	private var contentView: some View {
		VStack {
			if let errorMessage = viewModel.errorMessage {
				Text("Error: \(errorMessage)")
					.font(.system(size: 16, weight: .semibold))
					.foregroundStyle(Color("Error"))
			}
			CocktailCarousel(
				items: viewModel.featuredCocktails,
				isCarouselShowcase: true,
				navigateToSection: {},
				onCardPress: { id in
					router.routeTo(.cocktailDetails(CocktailDetailsArgs(id: id, rootSentFrom: TabRoutes.home)))
				}
			)
			ForEach(viewModel.sectons, id: \.category.id) { item in
				CocktailCarousel(
					items: item.cocktails,
					title: item.category.name,
					isCarouselShowcase: false,
					navigateToSection: {
						router.routeTo(.cocktailSection(
							CocktailSectionArgs(cocktails: item.cocktails, title: item.category.name)
						))
					},
					onCardPress: { id in
						router.routeTo(.cocktailDetails(CocktailDetailsArgs(id: id, rootSentFrom: TabRoutes.home)))
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
