//
//  AllSetViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation


@MainActor
class AllSetViewModel: ObservableObject {
	private final let authService: AuthService = .shared
	private final let userRepository: UserRepository = UserRepositoryImpl()
	
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	func recheck() async throws {
		isLoading = true
		defer {
			isLoading = false
		}
		do {
			guard let userId = userRepository.getUserId() else {
				throw UserManagerError.userIdNotFound
			}
			let user = try await authService.fetchUser()
			let userFlavours = try await authService.fetchLikedFlavours(userId: userId)
			let userCategories = try await authService.fetchCategoriesForLikedFlavours(userId: userId)
			
			userRepository.setUser(user)
			userRepository.setLikedFlavoursForUser(userFlavours)
			userRepository.setCategoriesForUser(userCategories)
			
			authService.isNewUser = false
		} catch UserManagerError.userIdNotFound {
			errorMessage = "User ID not found"
		} catch {
			errorMessage = "Something went wrong"
		}

	}
}
