//
//  RefreshTokenRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation
struct RefreshTokenRequest: NetworkRequest {
	typealias Response = RefreshTokenResponse
	
	let refreshToken: String
	let sessionId: String
	
	
	var path: String {
		return "/api/v1/refresh"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["refresh_token": refreshToken, "session_id": sessionId]
	}
	
	var requestEncoding: RequestEncoding {
		return .json
	}
	
	var accessType: AcessType {
		return .publicAccess
	}
	
	var files: [String : NetworkFile]? {
		return nil
	}
	
	
}
