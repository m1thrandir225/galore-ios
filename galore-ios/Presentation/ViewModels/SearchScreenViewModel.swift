//
//  SearchViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

@MainActor
class SearchScreenViewModel : ObservableObject {
	private let repository: CocktailRepository = CocktailRepositoryImpl.shared
	private let networkService: NetworkService = NetworkService.shared
	
	@Published var results: [Cocktail]? = nil
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	func listCocktail() {
		
	}
	
	/*
	 1. Check locally if the query is found.
	 2. If not then do a network request.
	 3. Save the results
	 */
	
	func searchCocktails(query: String) async {
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			let localCocktails = try repository.searchCocktails(for: query)
			if localCocktails.count > 0 {
				results = localCocktails
			} else {
				let networkResponse: [Cocktail] = try await searchCocktailsNetwork(query: query)
				
				//Try to add the ones you don't have locally
				repository.addCocktails(networkResponse)
				
				results = networkResponse
			}
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func searchCocktailsNetwork(query: String) async throws -> [Cocktail]{
		let request = ListCocktailsRequest(searchQuery: query)
		return try await networkService.execute(request)
	
	}
}
