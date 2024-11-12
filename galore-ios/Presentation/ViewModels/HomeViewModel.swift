//
//  HomeViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 8.11.24.
//
import Foundation

@MainActor
class HomeViewModel: ObservableObject {
	private var authService: AuthService = .shared
	@Published var errorMessage: String?
	
	
	func logout() async throws {
		do {
			try await authService.logout()
		} catch {
			errorMessage = error.localizedDescription
		}
	}

}
