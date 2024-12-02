//
//  CocktailGrid.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.11.24.
//
import SwiftUI

struct CocktailGrid : View {
	@State var items: [Cocktail]
	var title: String? = nil
	var onCardPress: () -> Void
	
	let columns = [GridItem(.fixed(180)), GridItem(.fixed(180))]

	init(items: [Cocktail], title: String? = nil, onCardPress: @escaping () -> Void) {
		self.items = items
		self.title = title
		self.onCardPress = onCardPress
	}
	
	var body: some View {
		if let title = title {
			ScrollView {
				LazyVGrid(columns: columns, alignment: .center, spacing: 24){
					ForEach(items, id: \.id) { item in
						CocktailCard (
							title: item.name,
							isLiked: false,
							imageURL: item.imageUrl.toUrl!,
							width: 180,
							onCardPress: onCardPress
						)
					}
				}
			}
			.navigationBarTitle(title)
			.navigationBarTitleDisplayMode(.large)
		} else {
			ScrollView {
				LazyVGrid(columns: columns, alignment: .center, spacing: 24){
					ForEach(items, id: \.id) { item in
						CocktailCard (
							title: item.name,
							isLiked: false,
							imageURL: item.imageUrl.toUrl!,
							width: 180,
							onCardPress: onCardPress
						)
					}
				}
			}
		}
		
	}
}

#Preview {
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
	NavigationView {
		CocktailGrid(items: cocktails, title: "Sugary Delight") {
		}
	}
}
