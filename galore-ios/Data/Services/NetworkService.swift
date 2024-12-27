//
//  NetworkManager.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

class NetworkService {
	static let shared = NetworkService()
	private let urlSession: URLSession
	private let tokenManager: TokenManager
	
	private init() {
		self.urlSession = NetworkService.defaultSession
		self.tokenManager = TokenManager.shared
	}
	
	private static var defaultSession: URLSession {
		let urlCache = URLCache(memoryCapacity: 0, diskCapacity: 0)
		
		let configuration = URLSessionConfiguration.default
		configuration.urlCache = urlCache
		configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
		
		return URLSession(configuration: configuration)
	}
	
	func execute<T: NetworkRequest>(_ request: T) async throws -> T.Response {
		var urlRequest: URLRequest;
		
		switch request.requestEncoding {
		case .json:
			urlRequest = try request.makeURLRequest()
		case .multipartFormData:
			guard request.files != nil else {
				throw NetworkError.missingFiles
			}
			urlRequest = try request.makeMultipartFormDataRequest()
		}
		
		if request.accessType == .privateAccess {
			if let accessToken = tokenManager.accessToken {
				urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
			}
		}
		let (data, response) = try await urlSession.data(for: urlRequest)
		
		guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
			let httpResponseError = response as? HTTPURLResponse
			var errorMessage: String?
			
			print("HTTP Status Code: \(httpResponseError?.statusCode ?? -1)")
			
			do {
				// Decoding the error response into a dictionary
				if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
				   let serverMessage = jsonObject["error"] as? String {
					errorMessage = serverMessage
				} else {
					errorMessage = "Unexpected error format in response."
				}
			} catch {
				print("Error decoding response data: \(error.localizedDescription)")
			}
			switch httpResponseError!.statusCode {
			case 400:
				throw NetworkError.badRequest(errorMessage: errorMessage)
			case 404:
				throw NetworkError.notFound(errorMessage: errorMessage)
			case 401:
				throw NetworkError.unauthorized(errorMessage: errorMessage)
			case 403:
				throw NetworkError.unauthorized(errorMessage: errorMessage)
			case 500:
				throw NetworkError.serverError(errorMessage: errorMessage)
			default:
				throw NetworkError.requestFailed(errorMessage: errorMessage)
				
			}
		}
		
		do {
			if T.Response.self == Int.self {
				return httpResponse.statusCode as! T.Response
			} else {
				return try JSONDecoder().decode(T.Response.self, from: data)
			}
		} catch {
			throw NetworkError.decodingFailed
		}
	}
}
