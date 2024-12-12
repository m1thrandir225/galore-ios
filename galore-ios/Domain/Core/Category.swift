//
//  Category.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.12.24.
//
import Foundation

public final class Category: Identifiable, Codable, Equatable {
	
	public static func == (lhs: Category, rhs: Category) -> Bool {
		lhs.id == rhs.id
		&& lhs.name == rhs.name
		&& lhs.tag == rhs.tag
		&& lhs.createdAt == rhs.createdAt
	}
	
	public let id: String
	public let name: String
	public let tag: String
	public let createdAt: Date
	
	public enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
		case tag = "tag"
		case createdAt = "created_at"
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.tag = try container.decode(String.self, forKey: .tag)
		self.createdAt = try container.decode(Date.self, forKey: .createdAt)
	}
	
	public init (id: String, name: String, tag: String, createdAt: Date) {
		self.id = id
		self.name = name
		self.tag = tag
		self.createdAt = createdAt
	}
}
