//
//  CocktailRepositoryImpl.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

final class CocktailRepositoryImpl : CocktailRepository {
	private let cocktailManager: CocktailManager = CocktailManager.shared
	
	func getCocktails() -> [Cocktail] {
		return cocktailManager.getCocktails()
	}
	
	func getCocktail(with id: String)  -> Cocktail? {
		return cocktailManager.getCocktail(with: id)
	}
	//Search if there is a match locally
	func searchCocktails(with query: String?) throws -> [Cocktail] {
		return try cocktailManager.searchCocktails(with: query)
	}
	
	func addCocktails(_ new: [Cocktail]) {
		cocktailManager.addCocktails(new)
	}
	
	func addCocktail(_ cocktail: Cocktail) {
		cocktailManager.addCocktail(cocktail)
	}
	
	func getFeatured()  -> [Cocktail] {
		return cocktailManager.getFeatured()
	}
	
	func addFeaturedCocktails(_ new: [Cocktail]) {
		cocktailManager.addFeaturedCocktails(new)
	}
	
}
