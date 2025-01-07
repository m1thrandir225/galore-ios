//
//  UserLikedCocktail.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//

public struct UserLikedCocktail: Codable, Equatable {
	public let cocktailId: String
	public let userId: String
	
	public static func == (lhs: UserLikedCocktail, rhs: UserLikedCocktail) -> Bool {
		lhs.cocktailId == rhs.cocktailId && lhs.userId == rhs.userId
	}
	public enum CodingKeys: String, CodingKey {
		case cocktailId = "cocktail_id"
		case userId = "user_id"
	}
	
	public init(flavourId: String, userId: String) {
		self.cocktailId = flavourId
		self.userId = userId
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.cocktailId = try container.decode(String.self, forKey: .cocktailId)
		self.userId = try container.decode(String.self, forKey: .userId)
	}
}
