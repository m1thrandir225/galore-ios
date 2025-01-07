//
//  CocktailGrid.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.11.24.
//
import SwiftUI

struct CocktailGrid: View {
	@Binding var items: [Cocktail]
	var onCardPress: (_: String) -> Void
	
	let columns = [
		GridItem(.flexible(minimum: 150), spacing: 16),
		GridItem(.flexible(minimum: 150), spacing: 16)
	]
	
	init(items: Binding<[Cocktail]>, onCardPress: @escaping (_: String) -> Void) {
		self._items = items
		self.onCardPress = onCardPress
	}
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			if items.count > 0 {
				LazyVGrid(
					columns: columns,
					alignment: .center,
					spacing: 16
				) {
					ForEach(items, id: \.id) { item in
						CocktailCard(
							id: item.id,
							title: item.name,
							imageURL: item.getMainImageURL(),
							minWidth: 150,
							maxWidth: .infinity,
							onCardPress: onCardPress
						)
						.transition(.opacity.combined(with: .blurReplace))
						.animation(.smooth, value: items)
					}
				}
				.padding(.horizontal, 16)
				.padding(.vertical, 16)

			} else {
				VStack(alignment: .center, spacing: 24){
					Image("noResults")
						.resizable()
						.scaledToFit()
						.frame(height: 200)
						.foregroundStyle(Color("MainColor"))
					Text("No items were found.")
						.font(.system(size: 20, weight: .semibold))
						.foregroundStyle(Color("MainColor"))
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.padding(24)
			}
		}
	}
}
#Preview {
	@Previewable @State var cocktails: [Cocktail] = [
	]
	
	CocktailGrid(items: $cocktails, onCardPress: { id in
	})
}
