//
//  UserCocktail.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//
public final class UserCocktail: Codable, Equatable, Identifiable {
	public static func == (lhs: UserCocktail, rhs: UserCocktail) -> Bool {
		lhs.id == rhs.id &&
		lhs.name == rhs.name &&
		lhs.image == rhs.image &&
		lhs.description == rhs.description &&
		lhs.ingredients == rhs.ingredients &&
		lhs.instructions == rhs.instructions &&
		lhs.embedding == rhs.embedding
	}
	public let id: String
	public let name: String
	public let image: String
	public let userId: String
	public let description: String
	public let ingredients: CocktailIngredientData
	public let instructions: UserCocktailInstructionData
	public let embedding: [Float32]
	
	public enum CodingKeys: String, CodingKey {
		case userId = "user_id"
		case id = "id"
		case name = "name"
		case description = "description"
		case instructions = "instructions"
		case ingredients = "ingredients"
		case embedding = "embedding"
		case image = "image"
	}
	
	public init(id: String, name: String, image: String, userId: String, description: String, ingredients: CocktailIngredientData, instructions: UserCocktailInstructionData, embedding: [Float32]) {
		self.id = id
		self.name = name
		self.image = image
		self.userId = userId
		self.description = description
		self.ingredients = ingredients
		self.instructions = instructions
		self.embedding = embedding
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.name = try container.decode(String.self, forKey: .name)
		self.image = try container.decode(String.self, forKey: .image)
		self.userId = try container.decode(String.self, forKey: .userId)
		self.description = try container.decode(String.self, forKey: .description)
		self.ingredients = try container.decode(CocktailIngredientData.self, forKey: .ingredients)
		self.instructions = try container.decode(UserCocktailInstructionData.self, forKey: .instructions)
		self.embedding = try container.decode([Float32].self, forKey: .embedding)
	}
}
