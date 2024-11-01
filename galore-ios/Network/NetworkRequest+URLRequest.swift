//
//  NetworkRequest+URLRequest.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

extension NetworkRequest {
	func makeURLRequest() throws -> URLRequest {
		guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
			throw NetworkError.invalidURL
		}
		
		if let parameters = parameters, method == .get {
			urlComponents.queryItems = parameters.map {
				URLQueryItem(name: $0.key, value: "\($0.value)")
			}
		}
		
		guard let url = urlComponents.url else {
			throw NetworkError.invalidURL
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = method.rawValue
		request.allHTTPHeaderFields = headers
		
		request.cachePolicy = method == .get ? .returnCacheDataElseLoad : .reloadIgnoringLocalCacheData
		
		if method != .get, let parameters = parameters {
			request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
		}
		
		return request
	}
}
