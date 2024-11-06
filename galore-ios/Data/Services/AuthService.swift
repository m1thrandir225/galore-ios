//
//  AuthService.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//
import Foundation

enum AuthError: Error {
	case invalidCredentials
	case invalidToken
	case invalidRefreshToken
	case userExists
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
	
	func register(email: String, password: String, name: String, birthday: Date, avatarFileUrl: URL)  async throws -> RegisterResponse {
		do {
			let request = RegisterRequest(email: email, password: password, name: name, birthday: birthday, avatarFileUrl: avatarFileUrl)
			
			return try await networkService.execute(request)
		} catch NetworkError.requestFailed {
			throw AuthError.userExists
		} catch {
			print(error.localizedDescription)
			throw AuthError.unknownError
		}
	}
	func logout(sessionId: String) async throws  -> LogoutResponse {
		do {
			let request = LogoutRequest(sessionId: sessionId)
			
			return try await networkService.execute(request)
		} catch {
			throw AuthError.unknownError
		}
	}
	
	func refreshToken(refreshToken: String, sessionId: String) async throws -> RefreshTokenResponse {
		do {
			let request = RefreshTokenRequest(refreshToken: refreshToken, sessionId: sessionId)
			
			return try await networkService.execute(request)
		} catch {
			throw AuthError.invalidRefreshToken
		}
	}
}
