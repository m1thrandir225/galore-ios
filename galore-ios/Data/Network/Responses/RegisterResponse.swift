//
//  RegisterResponse.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 4.11.24.
//
import Foundation

struct RegisterResponse: Codable {
	let user: User
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
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.user = try container.decode(User.self, forKey: .user)
		self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
		self.accessToken = try container.decode(String.self, forKey: .accessToken)
		
		if let refreshTokenExpiresAtString = try container.decodeIfPresent(String.self, forKey: .refreshTokenExpiresAt) {
			let dateFormatter = ISO8601DateFormatter()
			let formattedDate = dateFormatter.date(from: refreshTokenExpiresAtString)
			guard let formattedDate else {
				throw LoginError.invalidDate
			}
			
			self.refreshTokenExpiresAt = formattedDate
		} else {
			throw DecodingError.dataCorruptedError(forKey: .refreshTokenExpiresAt, in: container, debugDescription: "Missing access token expiration date")
		}
		if let accessTokenExpiresAt = try container.decodeIfPresent(String.self, forKey: .accessTokenExpiresAt) {
			let dateFormatter = ISO8601DateFormatter()
			let formattedDate = dateFormatter.date(from: accessTokenExpiresAt)
			guard let formattedDate else {
				throw LoginError.invalidDate
			}
			self.accessTokenExpiresAt = formattedDate
			
		} else {
			throw DecodingError.dataCorruptedError(forKey: .accessTokenExpiresAt, in: container, debugDescription: "Missing access token expiration date")
		}
		
		self.sessionId = try container.decode(String.self, forKey: .sessionId)
	}
}
