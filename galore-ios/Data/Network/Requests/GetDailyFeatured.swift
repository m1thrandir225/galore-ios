//
//  DailyFeatured.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.12.24.
//
import Foundation

struct GetDailyFeatured : NetworkRequest {
	typealias Response = [Cocktail]
	
	let timezone: String = TimeZone.current.identifier
	
	var path: String {
		return "/cocktails/featured"
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var headers: [String : String]? {
		return ["Content": "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["timezone": timezone]
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
