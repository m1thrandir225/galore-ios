//
//  CocktailRepositoryImpl.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

final class CocktailRepositoryImpl : CocktailRepository {
	static let shared = CocktailRepositoryImpl()
	
	private var cocktails: [Cocktail] = []
	
	func saveCocktails(with items: [Cocktail]) async throws {
		cocktails = items
	}
	
	func getCocktails() async throws -> [Cocktail] {
		return self.cocktails
	}
	
	func getCocktail(for id: String) async throws -> Cocktail? {
		return cocktails.first { item in
			item.id == id
		}
	}
	//Search if there is a match locally
	func searchCocktails(for query: String) throws -> [Cocktail] {
		return cocktails.filter { item in
			item.name.contains(query) || item.ingredients.contains { ingredient in
				ingredient.name.contains(query)
			}
		}
	}
	
	func addCocktails(_ new: [Cocktail]) {
		let existingIds = Set(cocktails.map { $0.id })
		let unique = new.filter { !existingIds.contains($0.id)}
	
		cocktails.append(contentsOf: unique)
	}
	
}
