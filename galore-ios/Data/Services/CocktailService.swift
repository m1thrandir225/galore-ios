//
//  CocktailService.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

class CocktailService {
	static let shared = CocktailService()
	
	private let networkService: NetworkService = NetworkService.shared
	private let cocktailRepository: CocktailRepository = CocktailRepositoryImpl()
	
	init() {
		Task {
			let request = GetCocktails(searchQuery: "")
			let response = try await networkService.execute(request)
			cocktailRepository.addCocktails(response)
		}
	}
	
	func fetchCocktails(query: String? = nil) async throws -> [Cocktail] {
		let request = GetCocktails(searchQuery: query)
		let response = try await networkService.execute(request)
		
		return response
	}
	
	func searchCocktails(query: String? = nil) async throws -> [Cocktail] {
		let localCocktails = try cocktailRepository.searchCocktails(with: query)
		
		if localCocktails.count > 0 {
			return localCocktails
		}
		
		
		let cocktails = try await fetchCocktails(query: query)
		//Try to add them if we don't have them locally
		cocktailRepository.addCocktails(cocktails)
		
		return cocktails
	}
}
