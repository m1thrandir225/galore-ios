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
	@Published var avatarURL: URL?
	@Published var isLoading: Bool = false
	
	private let authenticationRepository: AuthenticationRepository
	
	init(authenticationRepository: AuthenticationRepository) {
		self.authenticationRepository = authenticationRepository
	}
	
	// MARK: - Moving between steps
	var canContinueToPersonalization: Bool {
		!name.isEmpty && !email.isEmpty && !password.isEmpty
	}
	
	var canContinueToRegistration: Bool {
		canContinueToPersonalization && birthday != nil && avatarURL != nil
	}
	
	func canContinue(step: RegisterStep) -> Bool {
		switch step {
		case .info:
			return canContinueToPersonalization
		case .personalization:
			return canContinueToRegistration
		}
	}
	
	
	func register() async throws {
		do {
			self.isLoading = true
			//TODO: implement
			guard let avatarURL else { return }
			guard let birthday else { return }
			
			let response = try await authenticationRepository.register(
				email: email,
				password: password,
				name: name,
				birthday: birthday,
				avatarFileUrl: avatarURL
			)
			
			self.isLoading = false
			
		} catch {
			self.isLoading = false
			
		}
		
	}
}
