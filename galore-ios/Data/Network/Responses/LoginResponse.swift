//
//  LoginResponse.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

struct LoginResponse: Codable {
	let user: Account
	let refreshToken: String
	let accessToken: String
	let refreshTokenExpiresAt: Date
	let accessTokenExpiresAt: Date
	let sessionId: String
	
	private enum CodingKeys: String, CodingKey {
		 case user
		 case refreshToken = "refresh_token"
		 case accessToken = "access_token"
		 case refreshTokenExpiresAt = "refresh_token_expires_at"
		 case accessTokenExpiresAt = "access_token_expires_at"
		 case sessionId = "session_id"
	 }
}
