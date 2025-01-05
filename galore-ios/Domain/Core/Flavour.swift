//
//  Untitled.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//
import Foundation

public struct Flavour: Identifiable, Codable, Equatable {
	public let id: String
	public let name: String
	public let createdAt: String
	
	public static func == (lhs: Flavour, rhs: Flavour) -> Bool {
		lhs.id == rhs.id
		&& lhs.name == rhs.name
		&& lhs.createdAt == rhs.createdAt
	}
	
	public enum CodingKeys: String, CodingKey {
		case id
		case name
		case createdAt = "created_at"
	}
	
	public init(id: String, name: String, createdAt: String) {
		self.id = id
		self.name = name
		self.createdAt = createdAt
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.createdAt = try container.decode(String.self, forKey: .createdAt)
	}
	
}
