//
//  GeneratedCocktail.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.1.25.
//
import Foundation

public struct GeneratedCocktail : Identifiable, Equatable, Codable {
	public static func == (lhs: GeneratedCocktail, rhs: GeneratedCocktail) -> Bool {
		lhs.id == rhs.id
	}
	public let id: String
	public let userId: String
	public let requestId: String
	public let draftId: String
	public let name: String
	public let description: String
	public let mainImage: String
	public let ingredients: [CocktailIngredient]
	public let instructions: [GeneratedInstruction]
	public let createdAt: String
	
	public enum CodingKeys : String, CodingKey {
		case id = "id"
		case userId = "user_id"
		case requestId = "request_id"
		case draftId = "draft_id"
		case name
		case description
		case mainImage = "main_image_url"
		case ingredients
		case instructions
		case createdAt = "created_at"
	}
	
	init(id: String, userId: String, requestId: String, draftId: String, name: String, description: String, mainImage: String, ingredients: [CocktailIngredient], instructions: [GeneratedInstruction], createdAt: String) {
		self.id = id
		self.userId = userId
		self.requestId = requestId
		self.draftId = draftId
		self.name = name
		self.description = description
		self.mainImage = mainImage
		self.ingredients = ingredients
		self.instructions = instructions
		self.createdAt = createdAt
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(String.self, forKey: .id)
		self.userId = try container.decode(String.self, forKey: .userId)
		self.requestId = try container.decode(String.self, forKey: .requestId)
		self.draftId = try container.decode(String.self, forKey: .draftId)
		self.name = try container.decode(String.self, forKey: .name)
		self.description = try container.decode(String.self, forKey: .description)
		self.mainImage = try container.decode(String.self, forKey: .mainImage)
		let decodedIng = try container.decode(CocktailIngredientData.self, forKey: .ingredients)
		self.ingredients = decodedIng.ingredients
		let decodedIns = try container.decode(GeneratedInstructions.self, forKey: .instructions)
		self.instructions = decodedIns.instructions
		self.createdAt = try container.decode(String.self, forKey: .createdAt)
	}
	
	public func getMainImageURL() -> URL {
		return "\(Config.baseURL)/\(self.mainImage)".toUrl!
	}
	
	
	
}
