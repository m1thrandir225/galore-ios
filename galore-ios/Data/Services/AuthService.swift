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
	private let userManager: UserManager = UserManager.shared
	
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
	
	//TODO: network error handling
	func login(email: String, password: String) async throws  {
		do {
			let request = LoginRequest(email: email, password: password)
		
			let response = try await networkService.execute(request)
			
			tokenManager.storeTokens(accessToken: response.accessToken, refreshToken: response.refreshToken, sessionId: response.sessionId, accessTokenExpiresAt: response.accessTokenExpiresAt, refreshTokenExpiresAt: response.refreshTokenExpiresAt)
			
			userManager.setUser(response.user)
			
			isLoggedIn = true
		
		} catch NetworkError.requestFailed {
			isLoggedIn = false
			throw AuthError.invalidCredentials
		} catch  {
			print(error.localizedDescription)
			throw AuthError.unknownError
		}
	}
	
	func register(email: String, password: String, name: String, birthday: Date, networkFile: NetworkFile)  async throws {
		do {
			let request = RegisterRequest(email: email, password: password, name: name, birthday: birthday, networkFile: networkFile)
			
			let response = try await networkService.execute(request)
			
			tokenManager.storeTokens(accessToken: response.accessToken, refreshToken: response.refreshToken, sessionId: response.sessionId, accessTokenExpiresAt: response.accessTokenExpiresAt, refreshTokenExpiresAt: response.refreshTokenExpiresAt)
			
			userManager.setUser(response.user)
			
			self.isLoggedIn = true
		} catch NetworkError.requestFailed {
			self.isLoggedIn = false
			throw AuthError.userExists
		} catch {
			self.isLoggedIn = false
			print(error.localizedDescription)
			throw AuthError.unknownError
		}
	}
	func logout() async throws {
		self.isLoading = true
		defer {
			self.isLoading = false
		}
		do {
			guard let sessionId = tokenManager.sessionId else { throw TokenManagerError.sessionIdNotFound }
			
			let request = LogoutRequest(sessionId: sessionId)
			
			self.isLoggedIn = false
			
			let response = try await networkService.execute(request)
			if response.message.isEmpty { throw NetworkError.requestFailed }
			
			tokenManager.clearTokens()
			userManager.clearUser()
			
		} catch {
			self.isLoggedIn = false
			throw AuthError.unknownError
		}
	}
	
	func refreshToken() async throws {
		do {
			guard let refreshToken = tokenManager.refreshToken else { throw TokenManagerError.refreshTokenNotFound }
			guard let sessionId = tokenManager.sessionId else { throw TokenManagerError.sessionIdNotFound }
			
			let request = RefreshTokenRequest(refreshToken: refreshToken, sessionId: sessionId)
			let response = try await networkService.execute(request)
			
			tokenManager.accessToken = response.accessToken
			
		} catch {
			throw AuthError.invalidRefreshToken
		}
	}
	
	func fetchUser() async throws {
		do {
			guard let userId = tokenManager.sessionId else { throw UserManagerError.userIdNotFound }
		
			let request = UserRequest(userId: userId)
			let response = try await networkService.execute(request)
				
			userManager.setUser(response)
		} catch {
			throw AuthError.unknownError
		}
	}
	
	func refreshSession() async throws {
		self.isRefreshing = true
		self.isLoading = true
		
		defer {
			self.isRefreshing = false
			self.isLoading = false
		}
		try await self.refreshToken()
		try await self.fetchUser()
		
		
		self.isLoggedIn = true
	}
	

}
