//
//  RegisterViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation
import SwiftUI

@MainActor
class RegisterViewModel: ObservableObject {
	@Published var name: String = ""
	@Published var email: String = ""
	@Published var password: String = ""
	@Published var birthday: Date?
	@Published var networkFile: NetworkFile?
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	private let authService: AuthService = .shared
	
	// MARK: - Moving between steps
	var canContinueToPersonalization: Bool {
		!name.isEmpty && !email.isEmpty && !password.isEmpty
	}
	
	var canContinueToRegistration: Bool {
		canContinueToPersonalization && birthday != nil && networkFile != nil
	}
	
	func canContinue(step: RegisterStep) -> Bool {
		switch step {
		case .info:
			return canContinueToPersonalization
		case .personalization:
			return canContinueToRegistration
		}
	}
	
	
	func register(completion: () -> ()) async throws {
		self.isLoading = true
		defer {
			self.isLoading = false
		}
		do {
			//TODO: implement
			guard let networkFile else { return }
			guard let birthday else { return }
			guard !email.isEmpty else { return }
			guard !password.isEmpty else { return }
			guard !name.isEmpty else { return }
			
			
			try await authService.register(
				email: email,
				password: password,
				name: name,
				birthday: birthday,
				networkFile: networkFile
			)
			
			self.isLoading = false
			completion()
			
		} catch AuthError.userExists {
			errorMessage = "A user with this email already exists."
		} catch {
			errorMessage = "Something went wrong."
		}
		
	}
}
