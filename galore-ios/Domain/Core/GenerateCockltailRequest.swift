//
//  GenerateCockltailRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.1.25.
//
import Foundation

public final class GenerateCockltailRequest : Identifiable, Codable, Equatable {
	public let id: String
	public let userId: String
	public let prompt: String
	public let status: String
	public let errorMessage: String?
	public let updatedAt: String
	public let createdAt: String
	
	public static func == (lhs: GenerateCockltailRequest, rhs: GenerateCockltailRequest) -> Bool {
		lhs.id == rhs.id
		&& lhs.userId == rhs.userId
		&& lhs.prompt == rhs.prompt
		&& lhs.createdAt == rhs.createdAt
	}
	
	public init(id: String, userId: String, prompt: String, status: String, errorMessage: String?, updatedAt: String, createdAt: String) {
		self.id = id
		self.userId = userId
		self.prompt = prompt
		self.status = status
		self.errorMessage = errorMessage
		self.updatedAt = updatedAt
		self.createdAt = createdAt
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.userId = try container.decode(String.self, forKey: .userId)
		self.prompt = try container.decode(String.self, forKey: .prompt)
		self.status = try container.decode(String.self, forKey: .status)
		self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage)
		self.updatedAt = try container.decode(String.self, forKey: .updatedAt)
		self.createdAt = try container.decode(String.self, forKey: .createdAt)
	}
}
