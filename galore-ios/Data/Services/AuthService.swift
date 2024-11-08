//
//  AuthService.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//
import Foundation



@MainActor
class AuthService : ObservableObject {
	static let shared = AuthService()
	
	private let networkService: NetworkService = NetworkService.shared
	private let tokenManager: TokenManager = TokenManager.shared
	
	@Published var isLoggedIn: Bool = false
	@Published var isLoading: Bool = false
	@Published var isRefreshing: Bool = false
	
	private init() {}
	
	func checkAuthentication() async {
		let hasToken = tokenManager.isAuthenticated()
		let needsRefresh = tokenManager.shouldRefreshToken()
		
		if hasToken && !needsRefresh {
			self.isLoading = false
			self.isRefreshing = false
			self.isLoggedIn = true
		} else {
			do {
				try await refreshSession()
			} catch {
				self.isLoading = false
				self.isRefreshing = false
				self.isLoggedIn = false
			}
		}
	}
	
	
	func login(email: String, password: String) async throws -> LoginResponse {
		do {
			let request = LoginRequest(email: email, password: password)
		
			let response = try await networkService.execute(request)
			isLoggedIn = true
			return response
		} catch NetworkError.requestFailed {
			isLoggedIn = false
			throw AuthError.invalidCredentials
		} catch  {
			print(error.localizedDescription)
			throw AuthError.unknownError
		}
	}
	
	func register(email: String, password: String, name: String, birthday: Date, networkFile: NetworkFile)  async throws -> RegisterResponse {
		do {
			let request = RegisterRequest(email: email, password: password, name: name, birthday: birthday, networkFile: networkFile)
			
			let response = try await networkService.execute(request)
			
			self.isLoggedIn = true
			return response
		} catch NetworkError.requestFailed {
			self.isLoggedIn = false
			throw AuthError.userExists
		} catch {
			self.isLoggedIn = false
			print(error.localizedDescription)
			throw AuthError.unknownError
		}
	}
	func logout(sessionId: String) async throws  -> LogoutResponse {
		self.isLoading = true
		defer {
			self.isLoading = false
		}
		do {
			let request = LogoutRequest(sessionId: sessionId)
			
			self.isLoggedIn = false
			
			 let response = try await networkService.execute(request)
			
			return response
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
	
	func refreshSession() async throws {
		self.isRefreshing = true
		self.isLoading = true
		defer {
			self.isRefreshing = false
			self.isLoading = false
		}
		
		guard let refreshToken = tokenManager.refreshToken else { throw TokenManagerError.refreshTokenNotFound }
		guard let sessionId = tokenManager.sessionId else { throw TokenManagerError.sessionIdNotFound }
		let response = try await self.refreshToken(refreshToken: refreshToken, sessionId: sessionId)
		
		tokenManager.accessToken = response.accessToken
		
		self.isLoggedIn = true
	}
}
