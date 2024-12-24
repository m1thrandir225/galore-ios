//
//  GetCategories.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.12.24.
//
import Foundation

struct GetCategories : NetworkRequest {
	typealias Response = [Category]
	
	var path: String {
		return "/categories"
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
