//
//  UpdateUserProfile.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//
import Foundation

struct UpdateUserProfile : NetworkRequest {
	typealias Response = User
	let userId: String	
	let email: String
	let name: String
	let birthday: Date
	let networkFile: NetworkFile
	let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		return formatter
	}()
	
	var path: String {
		return "/users/\(userId)"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
	
	var parameters: [String : Any]? {
		return [
			"email": email,
			"name": name,
			"birthday": dateFormatter.string(from: birthday),
		]
	}
	
	var requestEncoding: RequestEncoding {
		return .multipartFormData
	}
	
	var accessType: AcessType {
		return .privateAccess
	}
	
	var files: [String : NetworkFile]? {
		return ["avatar_url": networkFile]
	}
	
	
}
