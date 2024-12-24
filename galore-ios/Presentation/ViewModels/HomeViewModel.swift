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
	@Published var featuredCocktails: [Cocktail] = []
	@Published var userRecommendedCocktails: [GetCocktailsForCategoryResponse] = []
	
	
	@MainActor
	func loadData() async {
		isLoading = true
		defer {
			isLoading = false
		}
		async let featured: () = getFeaturedCocktails()
		async let recommended: () = getCocktailsForUserCategories()
		
		let(_, _) = await (featured, recommended)
		
	}
	func logout() async throws {
		do {
			try await authService.logout()
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	
	func getFeaturedCocktails() async {
		do {
			let cocktails = try await cocktailService.getFeaturedCocktails()
			print(cocktails)
			featuredCocktails = cocktails
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func getCocktailsForUserCategories() async {
		do {
			if let categories = userManager.categoriesForUser {
				let results = try await cocktailService.getCocktailsForUserCategories(categories: categories)
				print(results)
				userRecommendedCocktails = results
			}
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
}
