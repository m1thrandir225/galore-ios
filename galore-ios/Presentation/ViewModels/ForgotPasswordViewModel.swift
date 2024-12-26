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
		
		defer {
			isLoading = false
		}
		
		do {
			let request = ForgotPasswordRequest(email: email)
			let response = try await networkService.execute(request)
			
			completionHandler()
			
		} catch {
			errorMessage = "Something went wrong"
 		}
	}
	
	func sendVerifyOTPRequest(completionHandler: @escaping () -> Void) async throws {
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			let request = VerifyOTPRequest(email: email, otp: code)
			let response = try await networkService.execute(request)
			
			
			passwordChangeRequest = response.resetPasswordRequest
			
			completionHandler()
		} catch {
			errorMessage = "The code you entered is incorrect."
		}
	}
}

