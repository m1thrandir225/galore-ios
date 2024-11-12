//
//  HomeViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 8.11.24.
//
import Foundation

class HomeViewModel: ObservableObject {
	private var authenticationRepository: AuthenticationRepository
	
	@Published var errorMessage: String?
	
	init(authenticationRepository: AuthenticationRepository) {
		self.authenticationRepository = authenticationRepository
	}
	
	func logout() async throws {
		do {
			try await authenticationRepository.logout()
		} catch {
			errorMessage = error.localizedDescription
		}
	}

}
