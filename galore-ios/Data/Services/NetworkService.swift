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
		let cacheSizeMemory = 50 * 1024 * 1024 //50mb
		let cacheSizeDisk = 100 * 1024 * 1024
		let urlCache = URLCache(memoryCapacity: cacheSizeMemory, diskCapacity: cacheSizeDisk)
		
		let configuration = URLSessionConfiguration.default
		configuration.urlCache = urlCache
		configuration.requestCachePolicy = .useProtocolCachePolicy
		
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
			print(response as? HTTPURLResponse ?? response)
			throw NetworkError.requestFailed
		}
		
		do {
			if T.Response.self == Int.self {
				return httpResponse.statusCode as! T.Response
			} else {
				return try JSONDecoder().decode(T.Response.self, from: data)
			}
		} catch {
			print(String(describing: error))
			throw NetworkError.decodingFailed
		}
	}
}
