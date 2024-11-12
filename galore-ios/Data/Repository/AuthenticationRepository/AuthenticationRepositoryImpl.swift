//
//  AuthenticationRepositoryImpl.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

import Foundation

final class AuthenticationRepositoryImpl: AuthenticationRepository {
	private let tokenManager: TokenManager = TokenManager.shared
	private let userManager: UserManager = UserManager.shared
	
	func needsRefreshToken() -> Bool {
		return tokenManager.shouldRefreshToken()
	}
	
	func isAuthenticated() -> Bool {
		return tokenManager.isAuthenticated()
	}
	func getSessionToken() -> String? {
		return tokenManager.sessionId
	}
	
	func getRefreshToken() -> String? {
		return tokenManager.refreshToken
	}
	
	func setAccessToken(_ accessToken: String) {
		tokenManager.accessToken = accessToken
	}
	
	func getUserId() -> String? {
		return userManager.userId
	}
	
	func setUser(_ user: User) {
		userManager.setUser(user)
	}
	
	
	func login(with response: LoginResponse) async throws {
		tokenManager.storeTokens(accessToken: response.accessToken, refreshToken: response.refreshToken, sessionId: response.sessionId, accessTokenExpiresAt: response.accessTokenExpiresAt, refreshTokenExpiresAt: response.refreshTokenExpiresAt)
		
		userManager.setUser(response.user)
	}
	
	func register(with response: RegisterResponse) async throws {
		tokenManager.storeTokens(accessToken: response.accessToken, refreshToken: response.refreshToken, sessionId: response.sessionId, accessTokenExpiresAt: response.accessTokenExpiresAt, refreshTokenExpiresAt: response.refreshTokenExpiresAt)
		
		userManager.setUser(response.user)
	}
	
	func logout() async throws {
		tokenManager.clearTokens()
		userManager.clearUser()
	}
	
	
}
