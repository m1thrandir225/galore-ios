//
//  NetworkManager.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

class NetworkService {
	private let urlSession: URLSession
	
	init(session: URLSession = .shared) {
		self.urlSession = session
	}
	
	func execute<T: NetworkRequest>(_ request: T) async throws -> T.Response {
		let urlRequest = try request.makeURLRequest()
		let (data, response) = try await urlSession.data(for: urlRequest)
		
		guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
			throw NetworkError.requestFailed
		}
		
		do {
			return try JSONDecoder().decode(T.Response.self, from: data)
		} catch {
			throw NetworkError.decodingFailed
		}
	}
}
