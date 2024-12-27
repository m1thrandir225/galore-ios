//
//  ForgotPasswordViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

@MainActor
class ForgotPasswordViewModel: ObservableObject {
	private final let networkService: NetworkService = .shared

	@Published var email: String = ""
	@Published var code: String = ""
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	@Published var passwordChangeRequest: ResetPasswordModel? = nil
	
	func sendForgotPasswordRequest(completionHandler: @escaping () -> Void) async throws {
		isLoading = true
		errorMessage = nil
		
		defer {
			isLoading = false
		}
		
		do {
			let request = ForgotPasswordRequest(email: email)
			_ = try await networkService.execute(request)
			
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
		} catch  {
			errorMessage = "Something went wrong"
		}
	}
	
	func sendVerifyOTPRequest(completionHandler: @escaping () -> Void) async throws {
		isLoading = true
		errorMessage = nil
		
		defer {
			isLoading = false
		}
		
		do {
			let request = VerifyOTPRequest(email: email, otp: code)
			let response = try await networkService.execute(request)
			
			
			passwordChangeRequest = response.resetPasswordRequest
			
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
}

