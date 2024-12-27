//
//  ForgotPasswordRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

struct ForgotPasswordRequest : NetworkRequest {
	typealias Response = Int
	
	let email: String
	
	var path: String {
		return "/forgot-password"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["email": email]
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
	
	init(email: String) {
		self.email = email
	}
	
	
}
