//
//  LikeCocktail.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.12.24.
//
import Foundation

enum LikeUnlikeStatus {
	case like
	case unlike
}

struct LikeUnlikeCocktail : NetworkRequest {
	typealias Response = Int

	let id: String
	let action: LikeUnlikeStatus
	
	var path: String {
		switch action {
		case .like:
			return "/cocktails/\(id)/like"
		case .unlike:
			return "/cocktails/\(id)/unlike"
		}
	}
	
	var method: HTTPMethod {
		return .post
	}
	
	var headers: [String : String]? {
		return nil
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
	
	init(id: String, action: LikeUnlikeStatus) {
		self.id = id
		self.action = action
	}
}
