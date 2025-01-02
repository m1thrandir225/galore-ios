//
//  GeneratedCocktailGrid.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
import SwiftUI

struct GeneratedCocktailGrid : View {
	@Binding var items: [GeneratedCocktail]
	var onCardPress: (_: String) -> Void
	let columns = [GridItem(.fixed(190)), GridItem(.fixed(190))]
	
	init(items: Binding<[GeneratedCocktail]>, onCardPress: @escaping (_: String) -> Void) {
		self._items = items
		self.onCardPress = onCardPress
	}
	
	var body: some View {
		LazyVGrid(columns: columns, alignment: .center){
			ForEach(items, id: \.id) { item in
				CocktailCard (
					id: item.id,
					title: item.name,
					imageURL: "\(Config.baseURL)/\(item.mainImage)".toUrl!,
					width: 190,
					onCardPress: onCardPress
				)
				.transition(.opacity.combined(with: .blurReplace))
				.animation(.smooth, value: items)
			}
		}
	}
}
