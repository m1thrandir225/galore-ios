//
//  LikeFlavours.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

struct LikeFlavours : NetworkRequest {
	typealias Response = Int //status code return
	
	let userId: String
	let flavourIds: [String]
	
	var path: String {
		return "/flavours/like"
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return ["Content-Type" : "application/json"]
	}
	
	var parameters: [String : Any]? {
		return ["user_id" : userId, "flavour_ids": flavourIds]
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
