//
//  CocktailRepository.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

protocol CocktailRepository {
	func saveCocktails(with items: [Cocktail]) async throws //save them to in-memory store
	func addCocktails(_ new: [Cocktail])
	func getCocktails() async throws -> [Cocktail] //fetch them from in-memory
	func getCocktail(for id: String) async throws -> Cocktail? // fetch single cocktail
	func searchCocktails(for query: String) throws -> [Cocktail]
}
