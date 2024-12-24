//
//  GetFlavour.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.12.24.
//
import Foundation


struct GetFlavour : NetworkRequest {
	typealias Response = Flavour
	
	var id: String
	
	var path: String {
		return "/flavours/\(id)"
	}
	
	var method: HTTPMethod {
		return .get
	}
	
	var headers: [String : String]? {
		return ["Content-Type" : "application/json"]
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
	
	init(id: String) {
		self.id = id
	}
	
	
}
