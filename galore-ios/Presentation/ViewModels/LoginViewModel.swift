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
	
	private let authenticationRepository: AuthenticationRepository
	
	init(authenticationRepository: AuthenticationRepository) {
		self.authenticationRepository = authenticationRepository
	}
	
	func login() async {
		isLoading = true
		errorMessage = nil
		
		do {
			let response = try await authenticationRepository.login(email: email, password: password)
			
			handleLoginSuccess(user: response)
			
		} catch {
			handleLoginFailure(error: error)
		}
	}
	
	private func handleLoginSuccess(user: User) {
		print("Login successful")
	}
	
	private func handleLoginFailure(error: Error) {
		print(error.localizedDescription)
		errorMessage = "\(error.localizedDescription)"
	}
}
