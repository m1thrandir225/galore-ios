//
//  Cocktail.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//
import Foundation

public struct Cocktail: Identifiable, Codable, Equatable {
	public static func == (lhs: Cocktail, rhs: Cocktail) -> Bool {
		lhs.id == rhs.id &&
		lhs.isAlchoholic == rhs.isAlchoholic &&
		lhs.embedding == rhs.embedding &&
		lhs.glass == rhs.glass &&
		lhs.imageUrl == rhs.imageUrl &&
		lhs.ingredients == rhs.ingredients &&
		lhs.instructions == rhs.instructions
	}
	public let id: String
	public let name: String
	public let isAlchoholic: Bool
	public let glass: String
	public let imageUrl: String
	public let embedding: [Float32]
	public let ingredients: [CocktailIngredient]
	public let instructions: String
	
	public enum CodingKeys: String, CodingKey {
		case id = "id"
		case name = "name"
		case isAlchoholic = "is_alcoholic"
		case glass = "glass"
		case imageUrl = "image"
		case embedding = "embedding"
		case ingredients = "ingredients"
		case instructions = "instructions"
	}
	
	public init(id: String, name: String, isAlchoholic: Bool, glass: String, imageUrl: String, embedding: [Float32], ingredients: [CocktailIngredient], instructions: String) {
		self.id = id
		self.name = name
		self.isAlchoholic = isAlchoholic
		self.glass = glass
		self.imageUrl = imageUrl
		self.embedding = embedding
		self.ingredients = ingredients
		self.instructions = instructions
	}
	
	public enum IngredientsCodingKeys: String, CodingKey {
		 case ingredients
	 }
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.isAlchoholic = try container.decode(Bool.self, forKey: .isAlchoholic)
		self.glass = try container.decode(String.self, forKey: .glass)
		self.imageUrl = "\(Config.baseURL)/\(try container.decode(String.self, forKey: .imageUrl))"
		self.embedding = try container.decode([Float32].self, forKey: .embedding)
		
		let ingredientsContainer = try container.nestedContainer(keyedBy: IngredientsCodingKeys.self, forKey: .ingredients)
		self.ingredients = try ingredientsContainer.decode([CocktailIngredient].self, forKey: .ingredients)
		
		
		self.instructions = try container.decode(String.self, forKey: .instructions)
	}
	
	public func getMainImageURL() -> URL {
		return self.imageUrl.toUrl!
	}
}
