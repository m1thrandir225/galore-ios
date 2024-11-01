//
//  CocktailIngredient.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//

public final class CocktailIngredientData: Codable, Sendable, Equatable {
	public static func == (lhs: CocktailIngredientData, rhs: CocktailIngredientData) -> Bool {
		lhs.ingredients == rhs.ingredients
	}
	
	public enum CodingKeys: String, CodingKey {
		case ingredients
	}
	public let ingredients: [CocktailIngredient]
	
	public init(ingredients: [CocktailIngredient]) {
		self.ingredients = ingredients
	}
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.ingredients = try container.decode([CocktailIngredient].self, forKey: .ingredients)
	}
}

public final class CocktailIngredient: Codable, Sendable, Equatable {
	public static func == (lhs: CocktailIngredient, rhs: CocktailIngredient) -> Bool {
		lhs.name == lhs.name && lhs.amount == rhs.amount
	}
	
	public let name: String
	public let amount: String
	
	public init(name: String, amount: String) {
		self.name = name
		self.amount = amount
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.name = try container.decode(String.self, forKey: .name)
		self.amount = try container.decode(String.self, forKey: .amount)
	}
	
	public enum CodingKeys: String, CodingKey {
		case name = "name"
		case amount = "amount"
	}
}
