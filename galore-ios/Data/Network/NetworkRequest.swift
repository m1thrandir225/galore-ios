//
//  NetworkRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

enum RequestEncoding {
	case json
	case multipartFormData
}

enum AcessType {
	case publicAccess
	case privateAccess
}

protocol NetworkRequest {
	associatedtype Response: Decodable
	
	var baseURL: URL { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var headers: [String: String]? { get }
	var parameters: [String: Any]? { get }
	var requestEncoding: RequestEncoding { get }
	var accessType: AcessType { get }
	var files: [String: URL]? { get }
	
}
