//
//  NetworkManager.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

class NetworkService {
	private let urlSession: URLSession
	private let tokenManager: TokenManager
	
	init(session: URLSession = NetworkService.defaultSession, tokenManager: TokenManager) {
		self.urlSession = session
		self.tokenManager = tokenManager
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
			guard let files = request.files else {
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
			print("Request Failed")
			throw NetworkError.requestFailed
		}
		
		do {
			return try JSONDecoder().decode(T.Response.self, from: data)
		} catch {
			print(String(describing: error))
			throw NetworkError.decodingFailed
		}
	}
}
