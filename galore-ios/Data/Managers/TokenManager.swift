//
//  TokenManager.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

class TokenManager {
	static let shared = TokenManager()
	
	private let userDefaults = UserDefaults.standard
	private let accessTokenKey: String = "accessToken"
	private let refreshTokenKey: String = "refreshToken"
	private let sessionIdKey: String = "sessionId"
	private let accessTokenExpiresAtKey = "accessTokenExpiresAt"
	private let refreshTokenExpiresAtKey = "refreshTokenExpiresAt"
	
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
	
	func clearTokens() {
		accessToken = nil
		refreshToken = nil
		sessionId = nil
		accessTokenExpiresAt = nil
		refreshTokenExpiresAt = nil
	}
	
	func isAccessTokenValid() -> Bool {
		guard let expiresAt = accessTokenExpiresAt else { return false }
		return Date() < expiresAt
	}
	
	func isRefreshTokenValid() -> Bool {
		guard let expiresAt = refreshTokenExpiresAt else { return false }
		return Date() < expiresAt
	}
}
