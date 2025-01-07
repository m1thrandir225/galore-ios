//
//  Session.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//
import Foundation

public struct Session: Codable, Identifiable, Equatable {
	public static func == (lhs: Session, rhs: Session) -> Bool {
		lhs.id == rhs.id
		&& lhs.email == rhs.email
		&& lhs.refreshToken == rhs.refreshToken
		&& lhs.userAgent == rhs.userAgent
		&& lhs.clientIp == rhs.clientIp
		&& lhs.isBlocked == rhs.isBlocked
		&& lhs.expiresAt == rhs.expiresAt
		&& lhs.createdAt == rhs.createdAt
	}
	public let id: String
	public let email: String
	public let refreshToken: String
	public let userAgent: String
	public let clientIp: String
	public let isBlocked: Bool
	public let expiresAt: Date
	public let createdAt: Date
	
	enum CodingKeys: String, CodingKey {
		case id = "id"
		case email = "email"
		case refreshToken = "refresh_token"
		case userAgent = "user_agent"
		case clientIp = "client_ip"
		case isBlocked = "is_blocked"
		case expiresAt = "expires_at"
		case createdAt = "created_at"
	}
	
	public init(id: String, email: String, refreshToken: String, userAgent: String, clientIp: String, isBlocked: Bool, expiresAt: Date, createdAt: Date) {
		self.id = id
		self.email = email
		self.refreshToken = refreshToken
		self.userAgent = userAgent
		self.clientIp = clientIp
		self.isBlocked = isBlocked
		self.expiresAt = expiresAt
		self.createdAt = createdAt
	}
	
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.email = try container.decode(String.self, forKey: .email)
		self.refreshToken = try container.decode(String.self, forKey: .refreshToken)
		self.userAgent = try container.decode(String.self, forKey: .userAgent)
		self.clientIp = try container.decode(String.self, forKey: .clientIp)
		self.isBlocked = try container.decode(Bool.self, forKey: .isBlocked)
		self.expiresAt = try container.decode(Date.self, forKey: .expiresAt)
		self.createdAt = try container.decode(Date.self, forKey: .createdAt)
	}
}
