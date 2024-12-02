//
//  SearchViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

@MainActor
class SearchScreenViewModel : ObservableObject {
	private let cocktailService: CocktailService = CocktailService.shared
	
	@Published var results: [Cocktail]? = nil
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	
	/*
	 1. Check locally if the query is found.
	 2. If not then do a network request.
	 3. Save the results
	 */
	
	func searchCocktail(with query: String) async {
		isLoading = true
		 
		defer {
			isLoading = false
		}
		
		do {
			let cocktails = try await cocktailService.searchCocktails(query: query)
			
			results = cocktails
			print(cocktails)
		} catch {
			errorMessage = error.localizedDescription
		}
	}
}
