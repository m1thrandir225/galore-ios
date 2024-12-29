//
//  DeleteAccountRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 29.12.24.
//
import Foundation

struct DeleteAccountRequest : NetworkRequest {
	typealias Response = Int
	
	let userId: String
	
	var path: String {
		return "/users/\(userId)"
	}
	
	var method: HTTPMethod {
		return .delete
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
		return .privateAccess
	}
	
	var files: [String : NetworkFile]? {
		return nil
	}
	
	
}
