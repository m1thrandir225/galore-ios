//
//  UserRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//
import Foundation

struct UserRequest : NetworkRequest {
	typealias Response = User
	
	let userId: String
	
	var path: String {
		return "/api/v1/users/\(userId)"
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
		.privateAccess
	}
	
	var files: [String : NetworkFile]? {
		return nil
	}
	
	
}
