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
	private let authenticationRepository: AuthenticationRepository = AuthenticationRepositoryImpl()
	
	@Published var isLoggedIn: Bool = false
	@Published var isLoading: Bool = false
	@Published var isRefreshing: Bool = false
	
	private init() {}
	
	func checkAuthentication() async {
		let hasToken = authenticationRepository.isAuthenticated()
		let needsRefresh = authenticationRepository.needsRefreshToken()
		
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
			
			try await authenticationRepository.login(with: response)

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
			
			try await authenticationRepository.register(with: response)
			
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
			guard let sessionId = authenticationRepository.getSessionToken() else { throw TokenManagerError.sessionIdNotFound }
			
			let request = LogoutRequest(sessionId: sessionId)
			
			self.isLoggedIn = false
			
			let response = try await networkService.execute(request)
			if response.message.isEmpty { throw NetworkError.requestFailed }
			
			
			try await authenticationRepository.logout()
			
		} catch {
			self.isLoggedIn = false
			throw AuthError.unknownError
		}
	}
	
	func refreshToken() async throws {
		do {
			guard let refreshToken = authenticationRepository.getSessionToken() else { throw TokenManagerError.refreshTokenNotFound }
			guard let sessionId = authenticationRepository.getRefreshToken() else { throw TokenManagerError.sessionIdNotFound }
			
			let request = RefreshTokenRequest(refreshToken: refreshToken, sessionId: sessionId)
			let response = try await networkService.execute(request)
			
			
			authenticationRepository.setAccessToken(response.accessToken)
			
		} catch {
			throw AuthError.invalidRefreshToken
		}
	}
	
	func fetchUser() async throws {
		do {
			guard let userId = authenticationRepository.getUserId() else { throw UserManagerError.userIdNotFound }
		
			let request = UserRequest(userId: userId)
			let response = try await networkService.execute(request)
				
			authenticationRepository.setUser(response)
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
