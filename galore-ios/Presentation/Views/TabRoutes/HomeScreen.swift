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
		VStack {
			switch(viewModel.isLoading, viewModel.errorMessage) {
			case(true, _):
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle(tint: Color("MainColor")))
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.transition(.move(edge: .leading).combined(with: .opacity))
			case (_, .some(let error)):
				VStack(alignment: .leading) {
					Text(error)
						.font(.system(size: 16, weight: .semibold))
						.foregroundStyle(Color("Error"))
						.transition(.move(edge: .leading).combined(with: .opacity))
				}.frame(maxWidth: .infinity, maxHeight: .infinity)
			case (false, nil):
				ScrollView (.vertical, showsIndicators: false) {
					contentView
						.transition(.move(edge: .leading).combined(with: .opacity))
				}.refreshable {
					Task {
						viewModel.clearCurrentData()
						await viewModel.loadData()
					}
				}
				
			default:
				EmptyView()
			}
		}
		.background(Color("Background"))
		.animation(.smooth, value: viewModel.isLoading)
		.animation(.smooth, value: viewModel.errorMessage)
		.task {
			await viewModel.loadData()
		}
		
	}
	
	private var contentView: some View {
		VStack {
			if let errorMessage = viewModel.errorMessage {
				ErrorMessage(text: errorMessage)
					.animation(.smooth, value: errorMessage)
			}
			CocktailCarousel(
				items: viewModel.featuredCocktails,
				isCarouselShowcase: true,
				navigateToSection: {},
				onCardPress: { id in
					router.routeTo(.cocktailDetails(CocktailDetailsArgs(id: id, rootSentFrom: TabRoutes.home)))
				}
			)
			.transition(.opacity.combined(with: .blurReplace))
			.animation(.spring(response: 0.6, dampingFraction: 0.8), value: viewModel.featuredCocktails)
			
			ForEach(Array(viewModel.homeSection.enumerated()), id: \.element.category.id) { index, item in
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
				.transition(.opacity.combined(with: .blurReplace))
			}
		}
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	HomeScreen(router: router)
}
