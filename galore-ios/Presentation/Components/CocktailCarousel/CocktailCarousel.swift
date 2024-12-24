//
//  CocktailCarousel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 15.11.24.
//
import SwiftUI

struct CocktailCarousel: View {
	var title: String?
	var items: [Cocktail]
	let isCarouselShowcase: Bool
	let onCardPress: (_: String) -> Void
	let navigateToSection: () -> Void
	
	
	init(items: [Cocktail], title: String? = nil, isCarouselShowcase: Bool, navigateToSection: @escaping () -> Void, onCardPress: @escaping (_: String) -> Void) {
		self.items = items
		self.title = title
		self.isCarouselShowcase = isCarouselShowcase
		self.onCardPress = onCardPress
		self.navigateToSection = navigateToSection
	}
	
	var body: some View {
		VStack (alignment: .leading) {
			if let title = title {
				HStack {
					Text(title)
						.font(.system(size: 28, weight: .bold))
						.foregroundStyle(Color("OnBackground"))
					Spacer()
					Button {
						navigateToSection()
					} label: {
						Image(systemName: "chevron.right")
							.foregroundStyle(Color("OnBackground"))
					}
				}.padding(.horizontal, 24)
			}
			GeometryReader { reader in
				SnapperView(size: reader.size,
							items: items,
							isCarouselShowcase: isCarouselShowcase,
							onCardPress: onCardPress
				)
			}.frame(height: 300)
		}
		
	}
}

struct SnapperView: View {
	let size: CGSize
	let items: [Cocktail]
	let isCarouselShowcase: Bool
	let onCardPress: (_: String) -> Void
	
	private let padding: CGFloat
	private let cardWidth: CGFloat
	private let spacing: CGFloat = 24.0
	private let maxSwipeDistance: CGFloat
	
	@State private var currentCardIndex: Int = 1
	@State private var isDragging: Bool = false
	@State private var totalDrag: CGFloat = 0.0
	
	
	init(size: CGSize, items: [Cocktail], isCarouselShowcase: Bool, onCardPress: @escaping(_: String) -> Void) {
		self.size = size
		self.items = items
		self.cardWidth = isCarouselShowcase ? size.width * 0.82 : 225
		self.padding = (size.width - cardWidth) / 2.0
		self.maxSwipeDistance = self.cardWidth + spacing
		self.isCarouselShowcase = isCarouselShowcase
		self.onCardPress = onCardPress
	}
	
	var body: some View {
		let offset: CGFloat = maxSwipeDistance - (maxSwipeDistance * CGFloat(currentCardIndex))
		LazyHStack(spacing: spacing) {
			ForEach(items, id: \.id) { item in
				CocktailCard(
					id: item.id,
					title: item.name,
					isLiked: false,
					imageURL: item.imageUrl.toUrl!,
					width: cardWidth,
					onCardPress: onCardPress
				)
				.offset(x: isDragging ? totalDrag : 0)
				.animation(.snappy(duration: 0.4, extraBounce: 0.2), value: isDragging)
			}
		}.padding(.horizontal, padding)
			.offset(x: offset, y:0)
			.gesture(
				DragGesture()
					.onChanged { value in
						isDragging = true
						totalDrag =  value.translation.width
					}
					.onEnded { value in
						totalDrag = 0.0
						isDragging = false
						
						if (value.translation.width < -(cardWidth / 2.0) && self.currentCardIndex < items.count) {
							self.currentCardIndex = self.currentCardIndex + 1
						}
						
						if (value.translation.width > (cardWidth / 2.0) && self.currentCardIndex > 1) {
							self.currentCardIndex = self.currentCardIndex - 1
						}
					}
			)
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
		)
	]
	ScrollView(.vertical, showsIndicators: false){
		LazyVStack (alignment: .leading, spacing: 24){
			CocktailCarousel(items: cocktails,
							 isCarouselShowcase: true,
							 navigateToSection: {},
							 onCardPress: { _ in}
			)
			CocktailCarousel(items: cocktails,
							 title: "Packing a punch",
							 isCarouselShowcase: false,
							 navigateToSection: {},
							 onCardPress: {_ in})
			
			CocktailCarousel(items: cocktails,
							 title: "Packing a punch",
							 isCarouselShowcase: false,
							 navigateToSection: {},
							 onCardPress: {_ in})
		}
	}.padding(.vertical)
	
}
