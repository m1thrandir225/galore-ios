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
	
	private let authService: AuthService = .shared
	

	
	func canContinue() -> Bool {
		return !email.isEmpty && !password.isEmpty
	}
	
	func login() async {
		isLoading = true
		errorMessage = nil
		
		defer {
			isLoading = false
		}
		
		do {
			try await authService.login(email: email, password: password)
		} catch {
			errorMessage = error.localizedDescription
		}
	}
}
