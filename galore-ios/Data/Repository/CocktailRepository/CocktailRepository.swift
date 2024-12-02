//
//  CocktailRepository.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

protocol CocktailRepository {
	func addCocktails(_ new: [Cocktail])
	func addCocktail(_ cocktail: Cocktail)
	func getCocktails() -> [Cocktail] //fetch them from in-memory
	func getCocktail(with id: String) throws -> Cocktail? // fetch single cocktail
	func searchCocktails(with query: String) throws -> [Cocktail]
}
