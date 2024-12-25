//
//  GetCocktailLikedStatus.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//
import Foundation

struct GetCocktailLikedStatus : NetworkRequest {
	typealias Response = Bool
	
	let cocktailId: String
	let userId: String
	
	var path: String {
		return "/cocktails/\(cocktailId)/is_liked"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type":"application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["user_id": userId]
	}
	
	var requestEncoding: RequestEncoding {
		return .json
	}
	
	var accessType: AcessType {
		return .privateAccess
	}
	
	var files: [String : NetworkFile]? {
		return nil
	}
	
	init(cocktailId: String, userId: String) {
		self.cocktailId = cocktailId
		self.userId = userId
	}
	
}
