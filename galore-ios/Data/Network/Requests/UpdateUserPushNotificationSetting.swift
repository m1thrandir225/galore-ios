//
//  UpdateUserPushNotificationSetting.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//
import Foundation

struct UpdateUserPushNotificationSetting : NetworkRequest {
	typealias Response = Bool
	
	let userId: String
	let status: Bool
	
	var path: String {
		return "/users/\(userId)/push-notifications"
	}
	
	var method: HTTPMethod {
		return .put
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["enabled": status]
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
