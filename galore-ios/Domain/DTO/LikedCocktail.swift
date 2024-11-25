//
//  LikedCocktail.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 20.11.24.
//
import Foundation

struct LikedCocktail: Codable {
	let id: String
	let name: String
	let isAlcoholic: Bool
	let glass: String
	let imageURL: String
	let instructions: String
	let ingredients: String
	let embedding: [Float32]
	let createdAt: String
	let id2: String
	let cocktailId: String
	let userId: String
	
	init(id: String, name: String, isAlcoholic: Bool, glass: String, imageURL: String, instructions: String, ingredients: String, embedding: [Float32], createdAt: String, id2: String, cocktailId: String, userId: String) {
		self.id = id
		self.name = name
		self.isAlcoholic = isAlcoholic
		self.glass = glass
		self.imageURL = imageURL
		self.instructions = instructions
		self.ingredients = ingredients
		self.embedding = embedding
		self.createdAt = createdAt
		self.id2 = id2
		self.cocktailId = cocktailId
		self.userId = userId
	}
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.isAlcoholic = try container.decode(Bool.self, forKey: .isAlcoholic)
		self.glass = try container.decode(String.self, forKey: .glass)
		self.imageURL = try container.decode(String.self, forKey: .imageURL)
		self.instructions = try container.decode(String.self, forKey: .instructions)
		self.ingredients = try container.decode(String.self, forKey: .ingredients)
		self.embedding = try container.decode([Float32].self, forKey: .embedding)
		self.createdAt = try container.decode(String.self, forKey: .createdAt)
		self.id2 = try container.decode(String.self, forKey: .id2)
		self.cocktailId = try container.decode(String.self, forKey: .cocktailId)
		self.userId = try container.decode(String.self, forKey: .userId)
	}
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case isAlcoholic = "is_alcoholic"
		case glass
		case imageURL = "image"
		case instructions
		case ingredients
		case embedding
		case createdAt = "created_at"
		case id2 = "id_2"
		case cocktailId = "cocktail_id"
		case userId = "user_id"
	}
	
}
