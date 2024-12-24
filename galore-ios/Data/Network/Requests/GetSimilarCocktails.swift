//
//  GetSimilarCocktails.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 23.12.24.
//
import Foundation

struct GetSimilarCocktails : NetworkRequest {
	typealias Response = [Cocktail]

	let cocktailId: String
	
	var path: String {
		return "/cocktails/\(cocktailId)/simillar"
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var headers: [String : String]? {
		return ["Content-Type":"application/json"]
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
