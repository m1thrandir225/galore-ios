//
//  ListCocktails.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

struct GetCocktails : NetworkRequest {
	typealias Response = [Cocktail]
	
	var searchQuery: String? = nil
	
	var path: String {
		return "/cocktails"
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String : Any]? {
		if let searchQuery = searchQuery {
			return ["search": searchQuery]
		}
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
	
	init(searchQuery: String? = nil) {
		self.searchQuery = searchQuery
	}
}
