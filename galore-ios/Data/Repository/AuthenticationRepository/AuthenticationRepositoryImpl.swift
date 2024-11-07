//
//  AuthenticationRepositoryImpl.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

import Foundation

@MainActor
final class AuthenticationRepositoryImpl: AuthenticationRepository {
	private let authService: AuthService
	private let tokenManager: TokenManager
	
	init() {
		self.authService = AuthService.shared
		self.tokenManager = TokenManager.shared
	}
	
	func login(email: String, password: String) async throws -> User {
		
		let response = try await authService.login(email: email, password: password)
		
		tokenManager.storeTokens(accessToken: response.accessToken, refreshToken: response.refreshToken, sessionId: response.sessionId, accessTokenExpiresAt: response.accessTokenExpiresAt, refreshTokenExpiresAt: response.refreshTokenExpiresAt)
		
		return response.user
	}
	
	func register(email: String, password: String, name: String, birthday: Date, avatarFileUrl: URL) async throws -> User {
		
		let response = try await authService.register(email: email, password: password, name: name, birthday: birthday, avatarFileUrl: avatarFileUrl)
		
		tokenManager.storeTokens(accessToken: response.accessToken, refreshToken: response.refreshToken, sessionId: response.sessionId, accessTokenExpiresAt: response.accessTokenExpiresAt, refreshTokenExpiresAt: response.refreshTokenExpiresAt)
		
		return response.user
	}
	
	func logout() async throws {
		//Get sessionId from tokenManager
		
		guard let sessionId = tokenManager.sessionId else { throw TokenManagerError.sessionIdNotFound }
		
		let response = try await authService.logout(sessionId: sessionId)
		
	}
	
	func refreshToken() async throws {
		//Get sessionId and refreshToken from tokenManager
		guard let refreshToken = tokenManager.refreshToken else { throw TokenManagerError.refreshTokenNotFound }
		guard let sessionId = tokenManager.sessionId else { throw TokenManagerError.sessionIdNotFound }
		
		let response = try await authService.refreshToken(refreshToken: refreshToken, sessionId: sessionId)
		
		tokenManager.accessToken = response.accessToken
	}
	
}
