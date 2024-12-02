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
	
	func searchCocktails(query: String = "") async throws -> [Cocktail] {
		
		let localCocktails = try cocktailRepository.searchCocktails(with: query)
		print(localCocktails.count)
		
		if localCocktails.count > 0 {
			return localCocktails
		}
		
		let request = ListCocktailsRequest(searchQuery: query)
		let response = try await networkService.execute(request)
		
		
		//Try to add them if we don't have them locally
		cocktailRepository.addCocktails(response)
		
		return response
	}
}
