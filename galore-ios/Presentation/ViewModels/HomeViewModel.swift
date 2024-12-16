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
	private var userManager: UserManager = .shared
	
	@Published var errorMessage: String?
	@Published var isLoading: Bool = false
	@Published var results: [Cocktail] = []
	@Published var featuredCocktails: [Cocktail] = []
	@Published var userRecommendedCocktails: [GetCocktailsForCategoryResponse] = []
 
	
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
	
	func getFeaturedCocktails() async {
		isLoading = true
		defer {
			isLoading = false
		}
		do {
			let cocktails = try await cocktailService.getFeaturedCocktails()
			featuredCocktails = cocktails
		} catch {
			errorMessage = error.localizedDescription
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
	
	func getCocktailsForUserCategories() async {
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			if let categories = userManager.categoriesForUser {
				let results = try await cocktailService.getCocktailsForUserCategories(categories: categories)
				userRecommendedCocktails = results
			}
		} catch {
			errorMessage = error.localizedDescription
		}
	}

}
