//
//  TokenManager.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

enum TokenManagerError: Error {
	case refreshTokenExpired
	case accessTokenExpired
	case invalidToken
	case invalidRefreshToken
	case invalidSessionId
	case refreshTokenNotFound
	case accessTokenNotFound
	case sessionIdNotFound
}

class TokenManager {
	static let shared = TokenManager()
	
	private let userDefaults = UserDefaults.standard
	private let accessTokenKey: String = "accessToken"
	private let refreshTokenKey: String = "refreshToken"
	private let sessionIdKey: String = "sessionId"
	private let accessTokenExpiresAtKey = "accessTokenExpiresAt"
	private let refreshTokenExpiresAtKey = "refreshTokenExpiresAt"
	
	private init() {}
	
	var accessToken: String? {
		get { userDefaults.string(forKey: accessTokenKey) }
		set { userDefaults.set(newValue, forKey: accessTokenKey) }
	}
	
	var refreshToken: String? {
		get { userDefaults.string(forKey: refreshTokenKey)}
		set { userDefaults.set(newValue, forKey: refreshTokenKey)}
	}
	
	var sessionId: String? {
		get { userDefaults.string(forKey: sessionIdKey) }
		set { userDefaults.set(newValue, forKey: sessionIdKey) }
	}
	
	var accessTokenExpiresAt: Date? {
		get { userDefaults.object(forKey: accessTokenExpiresAtKey) as? Date }
		set { userDefaults.set(newValue, forKey: accessTokenExpiresAtKey) }
	}
	
	var refreshTokenExpiresAt: Date? {
		get { userDefaults.object(forKey: refreshTokenExpiresAtKey) as? Date }
		set { userDefaults.set(newValue, forKey: refreshTokenExpiresAtKey) }
	}
	
	func storeTokens(accessToken: String, refreshToken: String, sessionId: String, accessTokenExpiresAt: Date, refreshTokenExpiresAt: Date) {
		self.accessToken = accessToken
		self.refreshToken = refreshToken
		self.sessionId = sessionId
		self.accessTokenExpiresAt = accessTokenExpiresAt
		self.refreshTokenExpiresAt = refreshTokenExpiresAt
	}
	
	func clearTokens() {
		accessToken = nil
		refreshToken = nil
		sessionId = nil
		accessTokenExpiresAt = nil
		refreshTokenExpiresAt = nil
	}
	
	func isAccessTokenValid() -> Bool {
		guard let expiresAt = accessTokenExpiresAt else { return false }
		print(Date() < expiresAt)
		return Date() < expiresAt
	}
	
	func isRefreshTokenValid() -> Bool {
		guard let expiresAt = refreshTokenExpiresAt else { return false }
		print(Date() < expiresAt)
		return Date() < expiresAt
	}
	
	func isAuthenticated() -> Bool {
		return accessToken != nil
	}
	
	func shouldRefreshToken() -> Bool {
		let accessTokenIsValid = isAccessTokenValid()
		let refreshTokenIsValid = isRefreshTokenValid()
		
		return !accessTokenIsValid && refreshTokenIsValid
	}
}
