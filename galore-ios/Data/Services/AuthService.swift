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
	
	func login(email: String, password: String) async throws -> LoginResponse {
		do {
			let request = LoginRequest(email: email, password: password)
			return try await networkService.execute(request)
		} catch NetworkError.requestFailed {
			throw AuthError.invalidCredentials
		} catch  {
			print(error.localizedDescription)
			throw AuthError.unknownError
		}
	}
}
