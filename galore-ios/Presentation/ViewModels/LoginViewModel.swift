//
//  LoginViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.11.24.
//

import Foundation

@MainActor
class LoginViewModel:  ObservableObject {
	@Published var email: String = ""
	@Published var password: String = ""
	@Published var isLoading: Bool = false
	@Published var errorMessage: String?
	
	private let authService: AuthService
	
	init(authService: AuthService) {
		self.authService = authService
	}
	
	func login() async {
		isLoading = true
		errorMessage = nil
		
		do {
			let response = try await authService.login(email:  email, password: password)
			
			handleLoginSuccess(response: response)
			
		} catch {
			handleLoginFailure(error: error)
		}
	}
	
	private func handleLoginSuccess(response: LoginResponse) {
		print(response.accessToken)
	}
	
	private func handleLoginFailure(error: Error) {
		print(error.localizedDescription)
		errorMessage = "\(error.localizedDescription)"
	}
}
