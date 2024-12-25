//
//  AuthenticationRepositoryImpl.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

import Foundation

final class AuthenticationRepositoryImpl: AuthenticationRepository {
	private let tokenManager: TokenManager = TokenManager.shared
	
	func shouldRefreshToken() -> Bool {
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
	func getAccessToken() -> String? {
		return tokenManager.accessToken
	}
	
	func setAccessToken(_ accessToken: String) {
		tokenManager.accessToken = accessToken
	}
	

	func login(with response: LoginResponse) {
		tokenManager.storeTokens(
			accessToken: response.accessToken,
			refreshToken: response.refreshToken,
			sessionId: response.sessionId,
			accessTokenExpiresAt: response.accessTokenExpiresAt,
			refreshTokenExpiresAt: response.refreshTokenExpiresAt
		)
	}
	
	func register(with response: RegisterResponse) {
		tokenManager.storeTokens(
			accessToken: response.accessToken,
			refreshToken: response.refreshToken,
			sessionId: response.sessionId,
			accessTokenExpiresAt: response.accessTokenExpiresAt,
			refreshTokenExpiresAt: response.refreshTokenExpiresAt)

	}
	
	func logout()  {
		tokenManager.clearTokens()
	}
	

}
