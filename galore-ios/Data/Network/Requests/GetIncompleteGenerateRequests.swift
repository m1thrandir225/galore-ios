//
//  GetIncompleteGenerateRequests.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
struct GetIncompleteGenerateRequests : NetworkRequest {
	typealias Response = [GenerateCocktailRequest]
	
	let userId: String
	
	var path: String {
		return "/users/\(userId)/generate-requests"
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
