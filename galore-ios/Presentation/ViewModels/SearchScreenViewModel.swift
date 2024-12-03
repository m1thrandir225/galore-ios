//
//  SearchViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

@MainActor
class SearchScreenViewModel : ObservableObject {
	private let cocktailService: CocktailService
	
	@Published var results: [Cocktail] = []
	@Published var hasSearchResults: Bool = false
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	init() {
		self.cocktailService = .shared
		Task {
			results = try await self.cocktailService.searchCocktails()
		}
	}
	
	
	/*
	 1. Check locally if the query is found.
	 2. If not then do a network request.
	 3. Save the results
	 */
	
	
	func searchCocktail(with query: String? = nil) async {
		isLoading = true
		defer {
			isLoading = false
			hasSearchResults = query != nil
		}
		
		do {
			let cocktails = try await cocktailService.searchCocktails(query: query)
			
			results = cocktails
		} catch {
			errorMessage = error.localizedDescription
		}
	}
}
