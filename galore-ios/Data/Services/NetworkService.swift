//
//  NetworkManager.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

class NetworkService {
	private let urlSession: URLSession
	
	init(session: URLSession = NetworkService.defaultSession) {
		self.urlSession = session
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
		let urlRequest = try request.makeURLRequest()
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
