//
//  CocktailService.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

class CocktailService {
	static let shared = CocktailService()
	
	private let userRepository: UserRepository = UserRepositoryImpl()
	private let networkService: NetworkService = NetworkService.shared
	private let cocktailRepository: CocktailRepository = CocktailRepositoryImpl()
	
	init() {
		Task {
			let request = GetCocktails(searchQuery: "")
			let response = try await networkService.execute(request)
			cocktailRepository.addCocktails(response)
		}
	}
	
	func fetchCocktails(query: String? = nil) async throws -> [Cocktail] {
		let request = GetCocktails(searchQuery: query)
		let response = try await networkService.execute(request)
		
		return response
	}
	
	func searchCocktails(query: String? = nil) async throws -> [Cocktail] {
		let localCocktails = try cocktailRepository.searchCocktails(with: query)
		
		if localCocktails.count > 0 {
			return localCocktails
		}
		
		
		let cocktails = try await fetchCocktails(query: query)
		//Try to add them if we don't have them locally
		cocktailRepository.addCocktails(cocktails)
		
		return cocktails
	}
	
	func fetchFeatured() async throws -> [Cocktail] {
		let request = GetDailyFeatured()
		let response = try await networkService.execute(request)
		
		return response
	}
	
	func fetchCocktail(with id: String) async throws -> Cocktail {
		let request = GetCocktail(id: id)
		let response = try await networkService.execute(request)
		
		return response
	}
	
	func likeCocktail(for id: String) async throws {
		let request = LikeUnlikeCocktail(id: id, action: LikeUnlikeStatus.like)
		
		_ = try await networkService.execute(request)
	}
	
	func unlikeCocktail(for id: String) async throws {
		let request = LikeUnlikeCocktail(id: id, action: LikeUnlikeStatus.unlike)
		
		_ = try await networkService.execute(request)
	}
	
	func fetchIsCocktailLikedByUser(for id: String) async throws -> Bool {
		guard userRepository.getUserId() != nil else { throw UserManagerError.userIdNotFound }
		
		let request = GetCocktailLikedStatus(cocktailId: id, userId: userRepository.getUserId()!)
		let response = try await networkService.execute(request)
		
		
		return response
	}
	
	func fetchUserLikedCocktails() async throws -> [Cocktail] {
		guard userRepository.getUserId() != nil else { throw UserManagerError.userIdNotFound }
		
		let request = GetUserLikedCocktails(id: userRepository.getUserId()!)
		
		let response = try await networkService.execute(request)
		
		return response
	}
	
	func getFeaturedCocktails() async throws -> [Cocktail] {
//		let localFeatured =  cocktailRepository.getFeatured()
//		
//		if localFeatured.count > 0 {
//			return localFeatured
//		}
		let cocktails = try await fetchFeatured()
		
		cocktailRepository.addFeaturedCocktails(cocktails)
		
		return cocktails
	}
	
	func getCocktail(with id: String) async throws -> Cocktail {
		let localCocktail = try cocktailRepository.getCocktail(with: id)
		
		if let localCocktail = localCocktail {
			return localCocktail
		}
		
		let cocktail = try await fetchCocktail(with: id)
		cocktailRepository.addCocktail(cocktail)
		
		return cocktail
	}
	
	func getCocktailsForUserCategories(categories: [Category]) async throws -> [GetCocktailsForCategoryResponse]{
		try await withThrowingTaskGroup(of: GetCocktailsForCategoryResponse.self) { group in
			// Create a task for each category
			for category in categories {
				group.addTask {
					let request = GetCocktailsForCategory(categoryId: category.id)
					return try await self.networkService.execute(request)
				}
			}
			
			// Collect results from all tasks
			var finalResult: [GetCocktailsForCategoryResponse] = []
			for try await response in group {
				finalResult.append(response)
			}
			
			return finalResult
		}
	}
	
	func fetchSimilarCocktails(for id: String) async throws -> [Cocktail]{
		let request = GetSimilarCocktails(cocktailId: id)
		let response = try await networkService.execute(request)
		
		return response
	}
}
