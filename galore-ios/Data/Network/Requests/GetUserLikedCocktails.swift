//
//  GetUserLikedCocktails.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.12.24.
//
import Foundation

struct GetUserLikedCocktails : NetworkRequest {
	typealias Response = [Cocktail]
	
	let id: String
	
	var path: String {
		return "/users/\(id)/cocktails"
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var headers: [String : String]? {
		return ["Content-Type" : "application/json"]
	}
	
	var parameters: [String : Any]? {
		return nil
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
	
	
}
