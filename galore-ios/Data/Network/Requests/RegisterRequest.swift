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
	let networkFile: NetworkFile
	let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()
	
	var parameters: [String : Any]? {
		return [
			"email": email,
			"password": password,
			"name": name,
			"birthday": dateFormatter.string(from: birthday),
		]
	}
	var requestEncoding: RequestEncoding {
		return .multipartFormData
	}
	
	var files: [String : NetworkFile]? {
		return ["avatar_url" : networkFile]
	}
	
}
