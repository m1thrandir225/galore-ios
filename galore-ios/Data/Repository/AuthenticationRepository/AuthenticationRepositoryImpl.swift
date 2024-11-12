//
//  AuthenticationRepositoryImpl.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

import Foundation

@MainActor
final class AuthenticationRepositoryImpl: AuthenticationRepository {
	
	private let authService: AuthService = AuthService.shared
	private let tokenManager: TokenManager = TokenManager.shared
	private let userManager: UserManager = UserManager.shared
	
	func login(email: String, password: String) async throws {
		try await authService.login(email: email, password: password)
	}
	
	func register(email: String, password: String, name: String, birthday: Date, networkFile: NetworkFile) async throws {
		
		try await authService.register(email: email, password: password, name: name, birthday: birthday, networkFile: networkFile)
		
	}
	
	func logout() async throws {
		 try await authService.logout()
	}
	
	
}
