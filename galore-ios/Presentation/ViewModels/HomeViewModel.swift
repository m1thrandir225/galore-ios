//
//  HomeViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 8.11.24.
//
import Foundation

@MainActor
class HomeViewModel: ObservableObject {
	private var authService: AuthService = .shared
	private var cocktailService: CocktailService = CocktailService.shared
	
	@Published var errorMessage: String?
	@Published var isLoading: Bool = false
	@Published var results: [Cocktail] = []
 
	
	func logout() async throws {
		do {
			try await authService.logout()
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func refresh() async {
		isLoading = true
		defer {
			isLoading = false
		}
		do {
			let cocktails = try await cocktailService.fetchCocktails()
			results = cocktails
		} catch {
			
		}
	}
	
	func getCocktails() async{
		isLoading = true
		defer {
			isLoading = false
		}
		do {
			let cocktails = try await cocktailService.searchCocktails()
			results = cocktails
		} catch {
			errorMessage = error.localizedDescription
		}
	}

}
