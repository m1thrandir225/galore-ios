//
//  FCMToken.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//

public struct FCMToken: Identifiable, Codable, Equatable, Sendable {
	public static func == (lhs: FCMToken, rhs: FCMToken) -> Bool {
		lhs.id == rhs.id &&
		lhs.token == rhs.token &&
		lhs.deviceId == rhs.deviceId &&
		lhs.userId == rhs.userId
	}
	
	public let id: String
	public let token: String
	public let deviceId: String
	public let userId: String
	
	public enum CodingKeys: String, CodingKey {
		case id = "id"
		case token = "token"
		case deviceId = "device_id"
		case userId = "user_id"
	}
	
	public init(id: String, token: String, deviceId: String, userId: String) {
		self.id = id
		self.token = token
		self.deviceId = deviceId
		self.userId = userId
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.token = try container.decode(String.self, forKey: .token)
		self.deviceId = try container.decode(String.self, forKey: .deviceId)
		self.userId = try container.decode(String.self, forKey: .userId)
	}
}
