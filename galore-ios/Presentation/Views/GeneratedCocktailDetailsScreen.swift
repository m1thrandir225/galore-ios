//
//  GeneratedCocktailDetailsScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
import SwiftUI
import NukeUI

struct GeneratedCocktailDetailsScreen : View {
	@StateObject  var router: Router<TabRoutes>
	@StateObject var viewModel: GenerateCocktailDetailsViewModel = GenerateCocktailDetailsViewModel()
	
	@State var currentTabIndex = 0
	
	var body: some View {
		VStack(alignment: .leading) {
			if viewModel.isLoading {
				ProgressView()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.tint(Color("MainColor"))
					.transition(.push(from: .bottom))
			} else {
				if let cocktail = viewModel.cocktail {
					ScrollView(.vertical, showsIndicators: false) {
						VStack {
							ZStack (alignment: .topLeading) {
								BackButton {
									
								}
								.safeAreaPadding(.all)
								.padding(.top, 24)
								.zIndex(1)
								
								LazyImage(url: cocktail.mainImage.toUrl) { state in
									if let image = state.image {
										image
											.resizable()
											.aspectRatio(contentMode: .fill)
											.frame(maxWidth: .infinity, minHeight: 300, maxHeight: 350)
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
									Text(cocktail.name)
										.font(.system(size: 32, weight: .bold))
										.foregroundStyle(Color("OnBackground"))
										.transition(.scale.combined(with: .push(from: .leading)))
										.padding(.top, 24)
									Text(cocktail.description)
										.font(.system(size: 18, weight: .regular))
										.foregroundStyle(Color("OnBackground"))
					
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
								
							}
							.padding(.horizontal, 24)
							VStack (alignment: .leading, spacing: 16){
								HStack {
									Text("Instructions")
										.font(.system(size: 24, weight: .semibold))
										.foregroundStyle(Color("OnBackground"))
									Spacer()
									Group {
										Text("\(currentTabIndex+1)")
											.foregroundStyle(Color("MainColor"))
										Text("/")
										Text("\(cocktail.instructions.count)")
									}
									
								}.padding(.horizontal, 24)
								
								TabView(selection: $currentTabIndex) {
									ForEach(cocktail.instructions.indices, id: \.self) { index in
										let currentItem = cocktail.instructions[index]
										VStack(spacing: 24) {
											LazyImage(url: currentItem.instructionImage.toUrl) { state in
												if let image = state.image {
													image
														.resizable()
														.aspectRatio(contentMode: .fill)
														.frame(maxWidth: .infinity, minHeight: 200, maxHeight: 250)
														.clipped()
														.clipShape(RoundedRectangle(cornerRadius: 16))
													
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
											Text(currentItem.instruction)
												.multilineTextAlignment(.leading)
										}
										.padding(.horizontal, 24)
										.tag(index)
									}
								}
								.frame(height: 400)
								.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
							}.padding(.vertical, 24)
							
							Spacer()
							VStack(alignment:  .leading, spacing: 12) {
								Text("Disclamer:")
									.font(.system(size: 12, weight: .bold))
									.foregroundStyle(Color("OnMainContainer"))
								Text("This cocktail recipe was generated using AI. While we've designed the process to provide creative and exciting combinations, the recipe has not been human-tested. Please enjoy responsibly and feel free to tweak it to your taste!")
									.font(.footnote)
									.foregroundStyle(Color("OnMainContainer"))
							}
							.padding(16)
							.background(Color("MainContainer"))
							.clipShape(RoundedRectangle(cornerRadius: 16))
							.overlay(
								RoundedRectangle(cornerRadius: 16)
									.stroke(Color("OnMainContainer"), lineWidth: 1)
							)
							
						}
					}
					.transition(.push(from: .bottom))
				}
			}
		}
		.animation(.smooth, value: viewModel.isLoading)
		.background(Color("Background"))
		.navigationBarBackButtonHidden(true)
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	let cocktail = GeneratedCocktail(
		id: "a291d560-177c-43b1-9458-73c167f01e10",
		userId: "aaf4333e-8c2e-4782-8713-b9aadd258793",
		requestId: "36575e2f-8de0-4d9d-b8e2-219ef8e4bb05",
		draftId: "2b98ea08-0e22-4283-a23d-ff1c9bf4d066",
		name: "Example Cocktail",
		description: "Lorem ipsum odor amet, consectetuer adipiscing elit. Condimentum curabitur tincidunt magna suspendisse porttitor fringilla facilisis iaculis phasellus. Sem torquent nisl condimentum convallis netus consequat ante. Nisi dis facilisis mus malesuada rutrum commodo finibus magnis parturient.",
		mainImage: "https://images.unsplash.com/photo-1470337458703-46ad1756a187?q=80&w=2069&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
		ingredients: [
			CocktailIngredient(name: "Ingredient 1", amount: "2"),
			CocktailIngredient(name: "Ingredient 2", amount: "3"),
			CocktailIngredient(name: "Ingredient 3", amount: "4")
		],
		instructions: [
			GeneratedInstruction(instruction: "Lorem ipsum odor amet, consectetuer adipiscing elit. Lacinia justo odio rutrum sodales cras phasellus, commodo vitae suspendisse.", instructionImage: "https://images.unsplash.com/photo-1620360290038-71942f99fa96?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
			GeneratedInstruction(instruction: "Lorem ipsum odor amet, consectetuer adipiscing elit. Lacinia justo odio rutrum sodales cras phasellus, commodo vitae suspendisse.", instructionImage: "https://images.unsplash.com/photo-1620360290038-71942f99fa96?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
			GeneratedInstruction(instruction: "Lorem ipsum odor amet, consectetuer adipiscing elit. Lacinia justo odio rutrum sodales cras phasellus, commodo vitae suspendisse.", instructionImage: "https://images.unsplash.com/photo-1620360290038-71942f99fa96?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
		],
		createdAt: Date().description)
	GeneratedCocktailDetailsScreen(router: router)
}
