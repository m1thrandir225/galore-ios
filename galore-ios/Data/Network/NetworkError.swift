//
//  NetworkError.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
	case invalidURL
	case requestFailed(errorMessage: String?)
	case notFound(errorMessage: String?)
	case badRequest(errorMessage: String?)
	case decodingFailed
	case missingFiles
	case unauthorized(errorMessage: String?)
	case serverError(errorMessage: String?)
	case unknown(Error)
	
	var localizedDescription: String {
		switch self {
		case .invalidURL:
			return "The provided URL is invalid"
		case .badRequest:
			return "The request was malformed"
		case .notFound:
			return "The resource you requested was not found"
		case .requestFailed:
			return "The request failed"
		case .decodingFailed:
			return "There was an error decoding the response"
		case .missingFiles:
			return "The response did not contain all required files"
		case .unauthorized:
			return "You are unauthorized"
		case .serverError:
			return "The server returned an error"
		case .unknown(let error):
			return error.localizedDescription
		}
		
		
	}
}
