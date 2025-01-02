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
	private final let userRepository: UserRepository = UserRepositoryImpl()
	private final let networkService: NetworkService = .shared
	@Published var userLikedCocktails: [Cocktail]? = nil
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	//TODO: Create separate model for AI generated cocktails
	@Published var userCreatedCocktails: [GeneratedCocktail]? = nil
	
	func loadData() async  {
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			
			async let userLikedCocktails: () = fetchUserLikedCocktails()
			async let userCreatedCocktails: () = fetchUserGeneratedCocktails()
			
			let (_, _) = try await (userLikedCocktails, userCreatedCocktails)
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
	
	func fetchUserGeneratedCocktails() async throws {
		guard let userId = userRepository.getUserId() else {
			errorMessage = "Missing user id."
			return
		}
		do {
			let request = GetUserGeneratedCocktails(userId: userId)
			let response = try await networkService.execute(request)
			
			userCreatedCocktails = response
		} catch {
			errorMessage = error.localizedDescription
		}
	}
}
