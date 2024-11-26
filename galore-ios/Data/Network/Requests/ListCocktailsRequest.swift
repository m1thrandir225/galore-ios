//
//  ListCocktails.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import Foundation

struct ListCocktailsRequest : NetworkRequest {
	typealias Response = [Cocktail]
	
	var searchQuery: String = ""
	
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
		return ["search": searchQuery]
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
	
	init(searchQuery: String = "") {
		self.searchQuery = searchQuery
	}
}
