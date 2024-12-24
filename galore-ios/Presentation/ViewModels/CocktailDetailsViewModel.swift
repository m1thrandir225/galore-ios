//
//  CocktailDetailsViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 17.12.24.
//
import Foundation
import SwiftUI

@MainActor
class CocktailDetailsViewModel : ObservableObject {
	private var cocktailService: CocktailService = CocktailService.shared
	
	@Published var errorMessage: String?
	@Published var isLoading: Bool = false
	@Published var cocktail: Cocktail? = nil
	@Published var similar: [Cocktail]? = nil
	
	func fetchCocktailDetails(for id: String) async {
		isLoading = true
		
		defer {
			isLoading = false
		}
		do {
			let details = try await cocktailService.getCocktail(with: id)
			
			await fetchSimillarCocktails(for: details.id)
			cocktail = details
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func fetchSimillarCocktails(for id: String) async {
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			let details = try await cocktailService.fetchSimilarCocktails(for: id)
			
			similar = details
		} catch {
			errorMessage = error.localizedDescription
		}
	}
}
