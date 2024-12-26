//
//  ResetPasswordRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

struct ResetPasswordNetworkRequest : NetworkRequest {
	typealias Response = Int
	
	let resetPasswordRequestId: String
	let newPassword: String
	let confirmPassword: String
	
	var path: String {
		return "/reset-password"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["password_request_id": resetPasswordRequestId, "new_password": newPassword, "confirm_password": confirmPassword]
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
