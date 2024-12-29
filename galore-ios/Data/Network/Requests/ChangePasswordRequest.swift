//
//  ChangePasswordRequesst.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 29.12.24.
//
import Foundation

struct ChangePasswordRequest : NetworkRequest {
	typealias Response = Int
	
	let userId: String
	let newPassword: String
	
	var path: String {
		return "/users/\(userId)/password"
	}
	
	var method: HTTPMethod {
		return .put
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["new_password": newPassword]
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
	
	init(userId: String, newPassword: String) {
		self.userId = userId
		self.newPassword = newPassword
	}
	
	
}
