//
//  Notification.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.12.24.
//
import Foundation

public struct Notification : Identifiable, Equatable, Codable {
	public static func == (lhs: Notification, rhs: Notification) -> Bool {
		lhs.id == rhs.id
		&& lhs.userId == rhs.userId
		&& lhs.notificationTypeId == rhs.notificationTypeId
		&& lhs.opened == rhs.opened
		&& lhs.createdAt == rhs.createdAt
	}
	
	public let id: String
	public let userId: String
	public let notificationTypeId: String
	public let opened: Bool
	public let createdAt: Date
	
	public enum CodingKeys : String, CodingKey {
		case id
		case userId = "user_id"
		case notificationTypeId = "notification_type_id"
		case opened
		case createdAt = "created_at"
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.userId = try container.decode(String.self, forKey: .userId)
		self.notificationTypeId = try container.decode(String.self, forKey: .notificationTypeId)
		self.opened = try container.decode(Bool.self, forKey: .opened)
		self.createdAt = try container.decode(Date.self, forKey: .createdAt)
	}
	
	public init(id: String, userId: String, notificationTypeId: String, opened: Bool, createdAt: Date) {
		self.id = id
		self.userId = userId
		self.notificationTypeId = notificationTypeId
		self.opened = opened
		self.createdAt = createdAt
	}
}
