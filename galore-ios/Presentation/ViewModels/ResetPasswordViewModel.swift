//
//  ResetPasswordViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

@MainActor
class ResetPasswordViewModel: ObservableObject {
	private final let networkServiced: NetworkService = .shared
	
	@Published var newPassword: String = ""
	@Published var confirmPassword: String = ""
	@Published var errorMessage: String?
	@Published var isLoading: Bool = false
	
	
	func isValid() -> Bool {
		newPassword.count >= 8 && newPassword == confirmPassword
	}
	
	func resetPassword(resetPasswordRequestId: String, completionHandler: @escaping () -> Void) async {
		isLoading = true
		defer {
			isLoading = false
		}
		do {
			let networkRequest = ResetPasswordRequest(resetPasswordRequestId: resetPasswordRequestId, newPassword: newPassword, confirmPassword: confirmPassword)
			let  _ = try await  networkServiced.execute(networkRequest)
			
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
			errorMessage = "Something went wrong."
		}
		
	}
}
