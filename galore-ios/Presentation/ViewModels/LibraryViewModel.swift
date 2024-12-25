//
//  LibraryViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//
import Foundation

@MainActor
class LibraryViewModel : ObservableObject {
	
	private final let cocktailService: CocktailService = .shared
	
	@Published var userLikedCocktails: [Cocktail]? = nil
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	//TODO: Create separate model for AI generated cocktails
	@Published var userCreatedCocktails: [Cocktail]? = nil
	
	func loadData() async  {
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			
			async let userLikedCocktails: () = fetchUserLikedCocktails()
			
			let (_) = try await (userLikedCocktails)
		} catch {
			
		}
	}
	
	func fetchUserLikedCocktails() async throws {
		do {
			let cocktails = try await cocktailService.fetchUserLikedCocktails()
			
			userLikedCocktails = cocktails
		} catch {
			errorMessage = error.localizedDescription
		}
	}
}
