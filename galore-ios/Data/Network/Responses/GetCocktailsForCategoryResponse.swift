//
//  ListCocktailsForCategoryResponse.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.12.24.
//
import Foundation

struct GetCocktailsForCategoryResponse: Codable{
	let category: Category
	let cocktails: [Cocktail]
	
	private enum CodingKeys: String, CodingKey {
		case category = "category"
		case cocktails = "cocktails"
	}
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.category = try container.decode(Category.self, forKey: .category)
		self.cocktails = try container.decode([Cocktail].self, forKey: .cocktails)
	}
	
	init(category: Category, cocktails: [Cocktail]) {
		self.category = category
		self.cocktails = cocktails
	}
}
