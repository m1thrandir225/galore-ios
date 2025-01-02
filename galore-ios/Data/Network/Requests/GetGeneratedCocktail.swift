//
//  GetGeneratedCocktail.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
import Foundation

struct GetGeneratedCocktail : NetworkRequest {
	typealias Response = GeneratedCocktail
	
	let cocktailId: String
	
	var path: String {
		return "/generated/\(cocktailId)"
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
