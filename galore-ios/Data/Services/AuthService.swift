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
	
	private let networkService: NetworkService
	private let tokenManager: TokenManager
	
	@Published var isLoggedIn: Bool = false
	@Published var isLoading: Bool = true
	@Published var isRefreshing: Bool = false
	
	private init() {
		self.networkService = NetworkService.shared
		self.tokenManager = TokenManager.shared
	}
	
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
			
			isLoggedIn = true
			
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
			
			isLoggedIn = false
			
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
	
	func refreshSession() async throws {
		self.isRefreshing = true
		self.isLoading = true
		
		guard let refreshToken = tokenManager.refreshToken else { throw TokenManagerError.refreshTokenNotFound }
		guard let sessionId = tokenManager.sessionId else { throw TokenManagerError.sessionIdNotFound }
		let response = try await self.refreshToken(refreshToken: refreshToken, sessionId: sessionId)
		
		tokenManager.accessToken = response.accessToken
		self.isLoggedIn = true
		self.isLoading = false
		self.isRefreshing = false
	}
}
