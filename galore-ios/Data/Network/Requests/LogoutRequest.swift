//
//  LogoutRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation

struct LogoutRequest: NetworkRequest {
	typealias Response = LogoutResponse
	
	let sessionId: String
	
	var path: String {
		return "/api/v1/logout"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["session_id": sessionId]
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
