//
//  LoginRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

struct LoginRequest: Codable, NetworkRequest {

	
	typealias Response = LoginResponse
	
	var accessType: AcessType {
		return .publicAccess
	}
	
	var baseURL: URL {
		return URL(string: "http://localhost:8080")!
	}
	
	var path: String {
		return "/api/v1/login"
	}

	var method: HTTPMethod {
		return .post
	}
	var headers: [String : String]?  {
		return ["Content-Type": "application/json"]
	}
	
	var requestEncoding: RequestEncoding {
		return .json
	}
	
	var files: [String : NetworkFile]? {
		return nil
	}
	
	let email: String
	let password: String
	
	var parameters: [String : Any]? {
		return ["email": email, "password": password]
	}
	
	
	
	private enum CodingKeys: String, CodingKey {
		case email
		case password
	}
}
