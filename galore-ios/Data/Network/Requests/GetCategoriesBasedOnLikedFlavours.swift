//
//  GetCategoriesBasedOnLikedFlavours.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 16.12.24.
//
import Foundation

struct GetCategoriesBasedOnLikedFlavours : NetworkRequest {
	typealias Response = [Category]

	let userId: String
	
	var path: String {
		return "/users/\(userId)/categories"
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
	
	init(userId: String) {
		self.userId = userId
	}
	
}
