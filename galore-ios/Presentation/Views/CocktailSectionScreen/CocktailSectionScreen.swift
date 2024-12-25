//
//  CocktailSectionScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//

import SwiftUI

struct CocktailSectionScreen: View {
	@StateObject var router: Router<TabRoutes>
	
	@State var cocktails: [Cocktail]
	@State var title: String
	@State var titleVisible: Bool = true
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			HStack {
				BackButton {
					router.dismiss()
				}
				Text(title)
					.font(.system(size: 24, weight: .semibold))
					.foregroundStyle(Color("OnBackground"))
					.padding(24)
					.opacity(titleVisible ? 0 : 1)
					.animation(.easeInOut, value: titleVisible)
				Spacer()
			}
			.padding(.leading, 24)
			ScrollView(.vertical, showsIndicators: false) {
				VStack (alignment: .leading) {
					TitleVisibilityCheckerView(title: title, titleVisible: $titleVisible)
					CocktailGrid(items: $cocktails, onCardPress: { id in
						router.routeTo(.cocktailDetails(CocktailDetailsArgs(id: id,rootSentFrom: nil)))
					})
				}
				
			}
		}
		.background(Color("Background"))
		.navigationBarBackButtonHidden(true)
	}
}

struct TitleVisibilityCheckerView: View {
	let title: String
	@Binding var titleVisible: Bool
	
	var body: some View {
		GeometryReader { geometry in
			Text(title)
				.font(.system(size: 48, weight: .bold))
				.foregroundStyle(Color("OnBackground"))
				.padding(24)
				.opacity(titleVisible ? 1 : 0)
				.animation(.easeInOut, value: titleVisible)
				.onChange(of: geometry.frame(in: .global).minY) { _, newValue in
					let threshold: CGFloat = 50 // Adjust this based on when you want the header to appear
					if newValue <= threshold && titleVisible {
						// Once scrolled out of view, make the header title appear
						titleVisible = false
					} else if newValue > threshold && !titleVisible {
						// Make the initial title visible again
						titleVisible = true
					}
				}
		}
		.frame(height: 100) // Adjust the height as needed for the text
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let cocktails: [Cocktail] = [
		Cocktail(
			id: "1",
			name: "Mojito",
			isAlchoholic: true,
			glass: "Highball glass",
			imageUrl: "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y29ja3RhaWx8ZW58MHx8MHx8fDA%3D",
			embedding: [0.1, 0.2, 0.3],
			ingredients: [
				CocktailIngredient(name: "White rum", amount: "50ml"),
				CocktailIngredient(name: "Mint leaves", amount: "10"),
				CocktailIngredient(name: "Lime juice", amount: "30ml"),
				CocktailIngredient(name: "Sugar syrup", amount: "2 tsp"),
				CocktailIngredient(name: "Soda water", amount: "Top up")
			],
			instructions: "Muddle the mint leaves with lime juice and sugar syrup. Add crushed ice and white rum. Top up with soda water and gently stir."
		),
		Cocktail(
			id: "2",
			name: "Pina Colada",
			isAlchoholic: true,
			glass: "Hurricane glass",
			imageUrl: "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y29ja3RhaWx8ZW58MHx8MHx8fDA%3D",
			embedding: [0.4, 0.5, 0.6],
			ingredients: [
				CocktailIngredient(name: "White rum", amount: "50ml"),
				CocktailIngredient(name: "Coconut cream", amount: "50ml"),
				CocktailIngredient(name: "Pineapple juice", amount: "100ml")
			],
			instructions: "Blend the rum, coconut cream, and pineapple juice with ice until smooth. Serve in a hurricane glass and garnish with pineapple."
		),
		Cocktail(
			id: "3",
			name: "Virgin Mary",
			isAlchoholic: false,
			glass: "Highball glass",
			imageUrl: "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y29ja3RhaWx8ZW58MHx8MHx8fDA%3D",
			embedding: [0.7, 0.8, 0.9],
			ingredients: [
				CocktailIngredient(name: "Tomato juice", amount: "120ml"),
				CocktailIngredient(name: "Lemon juice", amount: "15ml"),
				CocktailIngredient(name: "Worcestershire sauce", amount: "3 dashes"),
				CocktailIngredient(name: "Hot sauce", amount: "2 dashes"),
				CocktailIngredient(name: "Salt and pepper", amount: "To taste")
			],
			instructions: "Combine all the ingredients in a highball glass with ice. Stir gently and garnish with celery."
		),
		Cocktail(
			id: "4",
			name: "Virgin Mary",
			isAlchoholic: false,
			glass: "Highball glass",
			imageUrl: "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y29ja3RhaWx8ZW58MHx8MHx8fDA%3D",
			embedding: [0.7, 0.8, 0.9],
			ingredients: [
				CocktailIngredient(name: "Tomato juice", amount: "120ml"),
				CocktailIngredient(name: "Lemon juice", amount: "15ml"),
				CocktailIngredient(name: "Worcestershire sauce", amount: "3 dashes"),
				CocktailIngredient(name: "Hot sauce", amount: "2 dashes"),
				CocktailIngredient(name: "Salt and pepper", amount: "To taste")
			],
			instructions: "Combine all the ingredients in a highball glass with ice. Stir gently and garnish with celery."
		),
		Cocktail(
			id: "5",
			name: "Virgin Mary",
			isAlchoholic: false,
			glass: "Highball glass",
			imageUrl: "https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Y29ja3RhaWx8ZW58MHx8MHx8fDA%3D",
			embedding: [0.7, 0.8, 0.9],
			ingredients: [
				CocktailIngredient(name: "Tomato juice", amount: "120ml"),
				CocktailIngredient(name: "Lemon juice", amount: "15ml"),
				CocktailIngredient(name: "Worcestershire sauce", amount: "3 dashes"),
				CocktailIngredient(name: "Hot sauce", amount: "2 dashes"),
				CocktailIngredient(name: "Salt and pepper", amount: "To taste")
			],
			instructions: "Combine all the ingredients in a highball glass with ice. Stir gently and garnish with celery."
		)
	]
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	CocktailSectionScreen(
		router: router,
		cocktails: cocktails,
		title: "Section Title"
	)
}
