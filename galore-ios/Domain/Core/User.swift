//
//  Account.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//
import Foundation

public final class User: Codable, Equatable, Sendable, Identifiable {
	public static func == (lhs: User, rhs: User) -> Bool {
		lhs.id == rhs.id &&
		lhs.email == rhs.email &&
		lhs.name == rhs.name &&
		lhs.avatar == rhs.avatar &&
		lhs.birthday == rhs.birthday &&
		lhs.enabledPushNotifications == rhs.enabledPushNotifications &&
		lhs.enabledEmailNotifications == rhs.enabledEmailNotifications
	}
	public let id: String
	public let email: String
	public let name: String
	public let avatar: String?
	

	public let birthday: Date?
	public let enabledPushNotifications: Bool
	public let enabledEmailNotifications: Bool
	
	public init(id: String, email: String, name: String, avatar: String?, birthday: Date?, enabledPushNotifications: Bool, enabledEmailNotifications: Bool) {
		self.id = id
		self.email = email
		self.name = name
		self.avatar = avatar
		self.birthday = birthday
		self.enabledPushNotifications = enabledPushNotifications
		self.enabledEmailNotifications = enabledEmailNotifications
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.email = try container.decode(String.self, forKey: .email)
		self.name = try container.decode(String.self, forKey: .name)
		self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
		if let birthdayString = try container.decodeIfPresent(String.self, forKey: .birthday) {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd"
			self.birthday = dateFormatter.date(from: birthdayString)
		} else {
			self.birthday = nil
		}
		self.enabledPushNotifications = try container.decode(Bool.self, forKey: .enabledPushNotifications)
		self.enabledEmailNotifications = try container.decode(Bool.self, forKey: .enabledEmailNotifications)
	}

	public enum CodingKeys: String, CodingKey {
		case id = "id"
		case email = "email"
		case name = "name"
		case avatar = "avatar_url"
		case birthday = "birthday"
		case enabledPushNotifications = "enabled_push_notifications"
		case enabledEmailNotifications = "enabled_email_notifications"
	}
}
