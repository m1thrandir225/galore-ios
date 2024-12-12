//
//  CocktailsForCategory.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 3.12.24.
//
import Foundation

struct GetCocktailsForCategory : NetworkRequest {
	typealias Response = GetCocktailsForCategoryResponse
	
	var categoryId: String
	
	var path: String {
		return "/category/\(categoryId)/cocktails"
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
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
	
	init(categoryId: String) {
		self.categoryId = categoryId
	}
}
