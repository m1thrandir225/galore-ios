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
	
	func execute<T: NetworkRequest>(_ request: T, completion: @escaping (Result<T.Response, NetworkError>) -> Void) {
		   do {
			   let urlRequest = try request.makeURLRequest()
			   let task = urlSession.dataTask(with: urlRequest) { data, response, error in
				   
				   if let error = error {
					   completion(.failure(.unknown(error)))
					   return
				   }
				   
				   guard let data = data else {
					   completion(.failure(.requestFailed))
					   return
				   }
				   
				   do {
					   let decodedResponse = try JSONDecoder().decode(T.Response.self, from: data)
					   completion(.success(decodedResponse))
				   } catch {
					   completion(.failure(.decodingFailed))
				   }
			   }
			   task.resume()
		   } catch {
			   completion(.failure(.unknown(error)))
		   }
	   }
}
