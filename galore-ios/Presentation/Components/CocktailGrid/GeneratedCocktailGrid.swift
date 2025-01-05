//
//  GeneratedCocktailGrid.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
import SwiftUI

struct GeneratedCocktailGrid: View {
	@Binding var items: [GeneratedCocktail]
	var onCardPress: (_: String) -> Void
	
	let columns = [
		GridItem(.flexible(minimum: 150), spacing: 16),
		GridItem(.flexible(minimum: 150), spacing: 16)
	]
	
	init(items: Binding<[GeneratedCocktail]>, onCardPress: @escaping (_: String) -> Void) {
		self._items = items
		self.onCardPress = onCardPress
	}
	
	var body: some View {
		ScrollView {
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
		}
	}
}
