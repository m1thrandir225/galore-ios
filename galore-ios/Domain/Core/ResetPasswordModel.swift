//
//  ResetPasswordRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

public struct ResetPasswordModel: Identifiable, Codable, Equatable, Sendable {

	public static func == (lhs: ResetPasswordModel, rhs: ResetPasswordModel) -> Bool {
		lhs.id == rhs.id
		&& lhs.userId == rhs.userId
		&& lhs.passwordReset == rhs.passwordReset
		&& lhs.validUntil == rhs.validUntil
	}
	
	public let id: String
	public let userId: String
	public let passwordReset: Bool
	public let validUntil: Date?
	
	public enum CodingKeys: String, CodingKey {
		case id = "id"
		case userId = "user_id"
		case passwordReset = "password_reset"
		case validUntil = "valid_until"
	}
	
	public init(
		id: String,
		userId: String,
		passwordReset: Bool,
		validUntil: Date?
	) {
		self.id = id
		self.userId = userId
		self.passwordReset = passwordReset
		self.validUntil = validUntil
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(String.self, forKey: .id)
		userId = try container.decode(String.self, forKey: .userId)
		passwordReset = try container.decode(Bool.self, forKey: .passwordReset)
		
		
		if let validUntilString = try  container.decodeIfPresent(String.self, forKey: .validUntil) {
			
			let dateFormatter = DateFormatter()
			
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
			dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
			
			self.validUntil = dateFormatter.date(from: validUntilString)!
		} else {
			self.validUntil = nil
		}
			
	}
}
