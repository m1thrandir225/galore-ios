//
//  ChangePasswordViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 29.12.24.
//
import Foundation

@MainActor
class ChangePasswordViewModel: ObservableObject {
	private let networkService: NetworkService = .shared
	private let authService: AuthService = .shared
	private let authenticationRepository: AuthenticationRepository = AuthenticationRepositoryImpl()
	private let userRepository: UserRepository = UserRepositoryImpl()
	
	@Published var isLoading: Bool = false
	@Published var isDeleting: Bool = false
	@Published var errorMessage: String? = nil
	@Published var password: String = ""
	@Published var confirmPassword: String = ""
	
	func changePassword(completionHandler: @escaping() -> Void) async {
		guard password == confirmPassword else {
			errorMessage = "Passwords don't match"
			return
		}
		guard let userId = userRepository.getUserId() else {
			errorMessage = "User not logged in"
			return
		}
		
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			let request = ChangePasswordRequest(userId: userId, newPassword: password)
			_ = try await networkService.execute(request)
			
			try await authService.logout()
			
			completionHandler()
			
		} catch let error as NetworkError {
			switch error {
			case .badRequest(let message):
				errorMessage = message ?? "Something went wrong"
			case .notFound(let message):
				errorMessage = message ?? "Something went wrong"
			case .unauthorized(let message):
				errorMessage = message ?? "Something went wrong"
			case .serverError(let message):
				errorMessage = message ?? "Something went wrong"
			case .requestFailed(let message):
				errorMessage = message ?? "Something went wrong"
			default:
				errorMessage = "Something went wrong"
			}
		} catch {
			errorMessage = "Something went wrong"
		}
	}
	
	func deleteAccount() async {
		isDeleting = true
		
		guard let userId = userRepository.getUserId() else {
			errorMessage = "User not logged in"
			return
		}
		
		defer {
			isDeleting = false
		}
		
		do {
			let request = DeleteAccountRequest(userId: userId )
			_ = try await networkService.execute(request)
			
			authenticationRepository.deleteAccount()
			userRepository.clearUser()
			
			authService.isLoggedIn = false
		} catch {
			print(error.localizedDescription)
			errorMessage = "There was a problem deleting your account"
		}
			
	}
}
