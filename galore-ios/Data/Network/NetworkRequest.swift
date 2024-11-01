//
//  NetworkRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

protocol NetworkRequest {
	associatedtype Response: Decodable
	
	var baseURL: URL { get }
	var path: String { get }
	var method: HTTPMethod { get }
	var headers: [String: String]? { get }
	var parameters: [String: Any]? { get }
	
}
