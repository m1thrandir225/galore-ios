//
//  VerifyOTPRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

struct VerifyOTPRequest : NetworkRequest {
	typealias Response = VerifyOTPResponse
	
	let email: String
	let otp: String
	
	var path: String {
		return "/verify-otp"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["otp": otp, "email": email]
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
