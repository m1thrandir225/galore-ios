//
//  AuthService.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

enum AuthError: Error {
	case invalidCredentials
	case tokenExpired
	case unknownError
}

class AuthService {
	private let networkService: NetworkService
	
	init(networkService: NetworkService) {
		self.networkService = networkService
	}
	
	func login(username: String, password: String) async throws -> LoginResponse {
		do {
			let request = LoginRequest(email: username, password: password)
			let response: LoginResponse = try await networkService.execute(request)
			
			return try await networkService.execute(request)
		} catch NetworkError.requestFailed {
			throw AuthError.invalidCredentials
		} catch  {
			throw AuthError.unknownError
		}
	}
}
