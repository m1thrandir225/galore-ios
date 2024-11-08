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
	
	func login(email: String, password: String) async throws -> User {
		
		let response = try await authService.login(email: email, password: password)
		
		tokenManager.storeTokens(accessToken: response.accessToken, refreshToken: response.refreshToken, sessionId: response.sessionId, accessTokenExpiresAt: response.accessTokenExpiresAt, refreshTokenExpiresAt: response.refreshTokenExpiresAt)
		
		return response.user
	}
	
	func register(email: String, password: String, name: String, birthday: Date, networkFile: NetworkFile) async throws -> User {
		
		let response = try await authService.register(email: email, password: password, name: name, birthday: birthday, networkFile: networkFile)
		
		tokenManager.storeTokens(accessToken: response.accessToken, refreshToken: response.refreshToken, sessionId: response.sessionId, accessTokenExpiresAt: response.accessTokenExpiresAt, refreshTokenExpiresAt: response.refreshTokenExpiresAt)
		
		return response.user
	}
	
	func logout() async throws {
		//Get sessionId from tokenManager
		
		guard let sessionId = tokenManager.sessionId else { throw TokenManagerError.sessionIdNotFound }
		
		let  _ = try await authService.logout(sessionId: sessionId)
		
	}
	
	func refreshToken() async throws {
		//Get sessionId and refreshToken from tokenManager
		guard let refreshToken = tokenManager.refreshToken else { throw TokenManagerError.refreshTokenNotFound }
		guard let sessionId = tokenManager.sessionId else { throw TokenManagerError.sessionIdNotFound }
		
		let response = try await authService.refreshToken(refreshToken: refreshToken, sessionId: sessionId)
		
		tokenManager.accessToken = response.accessToken
	}
	
}
