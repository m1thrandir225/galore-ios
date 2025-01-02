//
//  GeneratedCocktailCarousel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//

import SwiftUI

struct GeneratedCocktailCarousel: View {
	var title: String?
	var items: [GeneratedCocktail]
	let onCardPress: (_: String) -> Void
	let navigateToSection: () -> Void
	
	
	init(items: [GeneratedCocktail], title: String? = nil, navigateToSection: @escaping () -> Void, onCardPress: @escaping (_: String) -> Void) {
		self.items = items
		self.title = title
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
					if !items.isEmpty {
						Button {
							navigateToSection()
						} label: {
							Image(systemName: "chevron.right")
								.foregroundStyle(Color("OnBackground"))
						}
					}

				}.padding(.horizontal, 24)
			}
			if items.isEmpty {
				VStack (alignment: .center){
					Image("noResults")
						.resizable()
						.scaledToFit()
						.frame(height: 50)
				}
				.frame(height: 100)
				.frame(maxWidth: .infinity)
				
				
			} else {
				GeometryReader { reader in
					GeneratedSnapperView(
						size: reader.size,
						items: items,
						onCardPress: onCardPress
					)
				}.frame(height: 300)
			}
			
		}.transition(.opacity.combined(with: .blurReplace))
		
	}
}

struct GeneratedSnapperView: View {
	let size: CGSize
	let items: [GeneratedCocktail]
	let onCardPress: (_: String) -> Void
	
	private let padding: CGFloat
	private let cardWidth: CGFloat
	private let spacing: CGFloat = 24.0
	private let maxSwipeDistance: CGFloat
	
	@State private var currentCardIndex: Int = 1
	@State private var isDragging: Bool = false
	@State private var totalDrag: CGFloat = 0.0
	
	
	init(size: CGSize, items: [GeneratedCocktail], onCardPress: @escaping(_: String) -> Void) {
		self.size = size
		self.items = items
		self.cardWidth = 225
		self.padding = 24
		self.maxSwipeDistance = self.cardWidth + spacing
		self.onCardPress = onCardPress
	}
	
	var body: some View {
		//let offset: CGFloat = maxSwipeDistance - (maxSwipeDistance * CGFloat(currentCardIndex)
		let offset: CGFloat = -CGFloat(currentCardIndex - 1) * (cardWidth + spacing) + totalDrag
		LazyHStack(spacing: spacing) {
			ForEach(items, id: \.id) { item in
				CocktailCard(
					id: item.id,
					title: item.name,
					imageURL: "\(Config.baseURL)/\(item.mainImage)".toUrl!,
					width: cardWidth,
					onCardPress: onCardPress
				)
				
			}
		}
		.padding(.horizontal, padding)
		.offset(x: offset, y:0)
		.animation(.spring(response: 0.4, dampingFraction: 0.8, blendDuration: 0.2),value: isDragging)
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

