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
	private var userRepository: UserRepository = UserRepositoryImpl()
	private var networkService: NetworkService = .shared
	
	@Published var errorMessage: String?
	@Published var isLoading: Bool = true
	@Published var featuredCocktails: [Cocktail] = []
	@Published var userRecommendedCocktails: [GetCocktailsForCategoryResponse] = []
	@Published var homeSection: [GetHomescreenResponse] = []
	
	func loadData() async {
		isLoading = true
		defer {
			isLoading = false
		}
		async let featured: () = getFeaturedCocktails()
		async let homescreen: () = getHomescreen()
		async let recommended: () = getCocktailsForUserCategories()
		
		let(_, _, _) = await (featured, recommended, homescreen)
		
	}
	func logout() async throws {
		do {
			try await authService.logout()
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func clearCurrentData() {
		errorMessage = nil
		
		userRecommendedCocktails = []
		homeSection = []
		featuredCocktails = []
	}
	
	func getHomescreen() async {
		guard homeSection.isEmpty else { return }
		
		do {
			guard let userId = userRepository.getUserId() else {
				throw UserManagerError.userIdNotFound
			}
			let request = GetHomescreen(userId: userId)
			let response = try await networkService.execute(request)
			
			homeSection = response
		} catch {
			errorMessage = "Error fetching homescreen"
		}
	}
	
	
	func getFeaturedCocktails() async {
		do {
			let cocktails = try await cocktailService.getFeaturedCocktails()
			featuredCocktails = cocktails
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func getCocktailsForUserCategories() async {
		do {
			if let categories = userRepository.getCategoriesForUser() {
				let results = try await cocktailService.getCocktailsForUserCategories(categories: categories)
				userRecommendedCocktails = results
			}
		} catch let error as NetworkError {
			switch error {
			case .badRequest(let message):
				errorMessage = message ?? "Status Code 400. Bad Request."
			case .notFound(let message):
				errorMessage = message ?? "Status Code 404. Content Not Found."
			case .unauthorized(let message):
				errorMessage = message ?? "Status Code 401. Unauthorized."
			case .serverError(let message):
				errorMessage = message ?? "Status Code 500. The server had an internal error."
			case .requestFailed(let message):
				errorMessage = message ?? "The request failed."
			default:
				errorMessage = "Something went wrong"
			}
		} catch {
			errorMessage = "Something went wrong. Please try again later."
		}
	}
	
}
