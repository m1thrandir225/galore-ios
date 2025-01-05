//
//  UserLikedFlavour.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//

public struct UserLikedFlavour: Codable, Equatable {
	public let flavourId: String
	public let userId: String
	
	public static func == (lhs: UserLikedFlavour, rhs: UserLikedFlavour) -> Bool {
		lhs.flavourId == rhs.flavourId && lhs.userId == rhs.userId
	}
	public enum CodingKeys: String, CodingKey {
		case flavourId = "flavour_id"
		case userId = "user_id"
	}
	
	public init(flavourId: String, userId: String) {
		self.flavourId = flavourId
		self.userId = userId
	}
	
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.flavourId = try container.decode(String.self, forKey: .flavourId)
		self.userId = try container.decode(String.self, forKey: .userId)
	}
}
