//
//  CocktailManager.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

final class CocktailManager {
	static let shared = CocktailManager()
	
	private var cocktails: [Cocktail] = []
	private var featured: [Cocktail] = []
	
	func getCocktails() -> [Cocktail] {
		return self.cocktails
	}
	func getFeatured() -> [Cocktail] {
		return self.featured
	}
	
	func getCocktail(with id: String) -> Cocktail? {
		return cocktails.first { item in
			item.id == id
		}
	}
	
	func addCocktail(_ cocktail: Cocktail) {
		cocktails.append(cocktail)
	}
	
	func addCocktails(_ new: [Cocktail]) {
		let existingIds = Set(cocktails.map { $0.id })
		let unique = new.filter { !existingIds.contains($0.id)}
	
		cocktails.append(contentsOf: unique)
	}
	
	func addFeaturedCocktails(_ new: [Cocktail]) {
		let existingIds = Set(featured.map {$0.id})
		let unique = new.filter { !existingIds.contains($0.id)}
		
		featured.append(contentsOf: unique)
	}
		
	func searchCocktails(with query: String?) throws -> [Cocktail ] {
		if let query = query {
			return cocktails.filter { item in
				item.name.contains(query) || item.ingredients.contains { ingredient in
					ingredient.name.contains(query)
				}
			}
		}
		return getCocktails()
		
	}
	
}
