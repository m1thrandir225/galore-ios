//
//  RegisterRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 4.11.24.
//
import Foundation

struct RegisterRequest: NetworkRequest {
	typealias Response = RegisterResponse
	
	var accessType: AcessType {
		return .publicAccess
	}
	
	var baseURL: URL {
		return URL(string: "http://localhost:8080")!
	}
	var path: String {
		return "/api/v1/register"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	let email: String
	let password: String
	let name: String
	let birthday: Date
	let avatarFileUrl: URL
	
	var parameters: [String : Any]? {
		return [
			"email": email,
			"password": password,
			"name": name,
			"birthday": birthday,
		]
	}
	var requestEncoding: RequestEncoding {
		return .multipartFormData
	}
	
	var files: [String : URL]? {
		return ["avatar_url" : avatarFileUrl]
	}
	
}