//
//  CocktailDetailsScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 17.12.24.
//
import SwiftUI
import NukeUI

struct CocktailDetailsScreen : View {
	@StateObject var router: Router<TabRoutes>
	@StateObject var viewModel: CocktailDetailsViewModel = CocktailDetailsViewModel()
	
	let cocktailId: String
	let rootSentFrom: (any Routable)?
	
	init(router: Router<TabRoutes>, cocktailId: String, rootSentFrom: (any Routable)? ) {
		_router = StateObject(wrappedValue: router)
		self.cocktailId = cocktailId
		self.rootSentFrom = rootSentFrom
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			if viewModel.isLoading {
				ProgressView()
			} else {
				if let cocktail = viewModel.cocktail {
					ScrollView(.vertical, showsIndicators: false) {
						VStack {
							ZStack (alignment: .topLeading) {
								HStack {
									BackButton {
										if let rootSentFrom = rootSentFrom {
											router.popUntil(rootSentFrom as! TabRoutes)
										} else {
											router.dismiss()
										}	
									}
				
									Spacer()
									if let isLikedByUser = viewModel.isLikedByUser {
										HeartButton(isPressed: isLikedByUser) {
											Task {
												try await viewModel.likeUnlikeCocktail(for: cocktail.id, action: isLikedByUser ? .unlike :  .like)
											}
										}
									}
					
								}
								.safeAreaPadding(.all)
								.padding(.top, 24)
								.zIndex(1)
								
								LazyImage(url: cocktail.imageUrl.toUrl) { state in
									if let image = state.image {
										image
											.resizable()
											.aspectRatio(contentMode: .fill)
											.frame(height: 350, alignment: .topLeading)
											.clipped()
										
									} else if state.isLoading {
										ProgressView()
									} else {
										Color.teritary
											.frame(height: 200)
											.clipShape(.rect(
												topLeadingRadius: 24,
												bottomLeadingRadius: 0,
												bottomTrailingRadius: 0,
												topTrailingRadius: 24
											))
										
									}
									
								}
							}
							
							VStack (alignment: .leading, spacing: 24) {
								HStack (alignment: .center) {
									Text(cocktail.name)
										.font(.system(size: 32, weight: .bold))
										.foregroundStyle(Color("OnBackground"))
										.transition(.scale.combined(with: .push(from: .leading)))
									Spacer()
									HStack {
										Image(systemName: "wineglass")
										Text(cocktail.glass)
											.font(.system(size: 18, weight: .medium))
											.foregroundStyle(Color("OnBackground"))
									}
									
								}.padding(.top, 24)
								
								
								VStack (alignment: .leading, spacing: 18) {
									Text("Instructions")
										.font(.system(size: 24, weight: .semibold))
										.foregroundStyle(Color("OnBackground"))
									Text(cocktail.instructions)
										.font(.system(size: 18, weight: .regular))
										.foregroundStyle(Color("OnBackground"))
								}
								
								VStack (alignment: .leading, spacing: 18) {
									Text("Ingredients")
										.font(.system(size: 24, weight: .semibold))
										.foregroundStyle(Color("OnBackground"))
									
									VStack(alignment: .leading, spacing: 12) {
										ForEach(cocktail.ingredients, id:\.name) { ingredient in
											HStack {
												Text(ingredient.name)
													.font(.system(size: 20))
													.foregroundStyle(Color("OnBackground"))
												Spacer()
												Text(ingredient.amount)
													.font(.system(size: 18, weight: .medium))
													.foregroundStyle(Color("OnBackground"))
											}
											
											.padding(.all, 12)
											.background(Color.main.opacity(0.2)).clipShape(RoundedRectangle(cornerRadius: 8))
										}
									}
								}
								if let similar = viewModel.similar {
									Text("Simillar")
										.font(.system(size: 24, weight: .semibold))
										.foregroundStyle(Color("OnBackground"))
									
									CocktailCarousel(
										items: similar,
										isCarouselShowcase: false,
										navigateToSection: {},
										onCardPress: {id in
											router.routeTo(.cocktailDetails(CocktailDetailsArgs(id: id, rootSentFrom: TabRoutes.home)))
										}
									)
								}
							}
							.padding(.horizontal, 24)
							Spacer()
							
						}
					}
				}
				
			}
		}
		.background(Color.background)
		.navigationBarBackButtonHidden(true)
		.task {
				await viewModel.loadData(for: cocktailId)
		}
		
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	

	CocktailDetailsScreen(router: router, cocktailId: "hello", rootSentFrom: TabRoutes.home)
}
