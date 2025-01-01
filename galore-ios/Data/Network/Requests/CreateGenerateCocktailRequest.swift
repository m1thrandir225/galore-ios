//
//  CreateGenerateCocktailRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.1.25.
//
import Foundation

struct CreateGenerateCocktailRequest : NetworkRequest {
	typealias Response = Int
	
	let referenceCocktailNames: [String]
	let referenceFlavourNames: [String]
	
	var path: String {
		return "/generate-cocktail"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type" : "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["reference_flavours" : referenceFlavourNames, "reference_cocktails" : referenceCocktailNames]
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
