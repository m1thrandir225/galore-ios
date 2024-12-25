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
	private let userRepository: UserRepository = UserRepositoryImpl()
	
	
	@Published var isLoggedIn: Bool = false
	@Published var isLoading: Bool = false
	@Published var isRefreshing: Bool = false
	@Published var isNewUser: Bool = false
	
	private init() {}
	
	func checkAuthentication() async {
		let hasToken = authenticationRepository.isAuthenticated()
		let needsRefresh = authenticationRepository.shouldRefreshToken()
		
		if hasToken && !needsRefresh {
			self.isLoading = true
			defer {
				isLoading = false
			}
			
			self.isRefreshing = false
			
			do {
				let user = try await self.fetchUser()
				let userCategories = try await self.fetchCategoriesForLikedFlavours(userId: user.id)
				let userFlavours = try await self.fetchLikedFlavours(userId: user.id)
				
				userRepository.setUser(user)
				userRepository.setCategoriesForUser(userCategories)
				userRepository.setLikedFlavoursForUser(userFlavours)
				
				print(userFlavours.count)
				
				if (userFlavours.count == 0) {
					isNewUser = true
				}
				self.isLoggedIn = true
			} catch {
				print(error.localizedDescription)
			}
		} else {
			do {
				try await refreshSession()
			} catch {
				self.isLoading = false
				self.isRefreshing = false
				self.isLoggedIn = false
				self.isNewUser = false
			}
		}
	}
	
	//TODO: network error handling
	func login(email: String, password: String) async throws  {
		do {
			let request = LoginRequest(email: email, password: password)
			let response = try await networkService.execute(request)
			authenticationRepository.login(with: response)
			userRepository.setUser(response.user)
			
			let userCategories = try await self.fetchCategoriesForLikedFlavours(userId: response.user.id)
			let userFlavours = try await self.fetchLikedFlavours(userId: response.user.id)
			userRepository.setCategoriesForUser(userCategories)
			userRepository.setLikedFlavoursForUser(userFlavours)
			
			if(userFlavours.count == 0) {
				isNewUser = true
			}
			
			isLoggedIn = true
		
		} catch NetworkError.requestFailed {
			isLoggedIn = false
			throw AuthError.invalidCredentials
		} catch  {
			print(error.localizedDescription)
			throw AuthError.unknownError
		}
	}
	
	func fetchLikedFlavours(userId: String) async throws -> [Flavour] {
		let request = GetUserLikedFlavours(id: userId)
		
		let response = try await networkService.execute(request)
		
		return response
	}
	
	func fetchCategoriesForLikedFlavours(userId: String) async throws -> [Category] {
		let request = GetCategoriesBasedOnLikedFlavours(userId: userId)
		
		let response = try await networkService.execute(request)
		
		return response
	}
	
	
	func register(email: String, password: String, name: String, birthday: Date, networkFile: NetworkFile)  async throws {
		do {
			let request = RegisterRequest(email: email, password: password, name: name, birthday: birthday, networkFile: networkFile)
			
			let response = try await networkService.execute(request)
			
			authenticationRepository.register(with: response)
			userRepository.setUser(response.user)
			
			self.isLoggedIn = true
			self.isNewUser = true
			
		} catch NetworkError.requestFailed {
			self.isLoggedIn = false
			self.isNewUser = false
			throw AuthError.userExists
		} catch {
			self.isLoggedIn = false
			self.isNewUser = false
			
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
			
			let response = try await networkService.execute(request)
			if response.message.isEmpty { throw NetworkError.requestFailed }
			
			authenticationRepository.logout()
			userRepository.clearUser()
			
			self.isLoggedIn = false
			
		} catch {
			self.isLoggedIn = false
			throw AuthError.unknownError
		}
	}
	
	func refreshToken() async throws {
		do {
			guard let refreshToken = authenticationRepository.getRefreshToken() else { throw TokenManagerError.refreshTokenNotFound }
			guard let sessionId = authenticationRepository.getSessionToken() else { throw TokenManagerError.sessionIdNotFound }
			
			
			let request = RefreshTokenRequest(refreshToken: refreshToken, sessionId: sessionId)
			let response = try await networkService.execute(request)
			
			authenticationRepository.setAccessToken(response.accessToken)
			
		} catch {
			throw AuthError.invalidRefreshToken
		}
	}
	
	func fetchUser() async throws -> User {
		do {
			guard let userId = userRepository.getUserId() else { throw UserManagerError.userIdNotFound }
		
			let request = UserRequest(userId: userId)
			let response = try await networkService.execute(request)
			
			return response
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
		
		let user = try await self.fetchUser()
		userRepository.setUser(user)
		
		let userCategories =  try await self.fetchCategoriesForLikedFlavours(userId: user.id)
		userRepository.setCategoriesForUser(userCategories)
		
		let userFlavours = try await self.fetchLikedFlavours(userId: user.id)
		userRepository.setLikedFlavoursForUser(userFlavours)
		
		print(userFlavours.count)
		
		if userFlavours.count == 0 {
			self.isNewUser = true
		}
		self.isLoggedIn = true
	}
	

}
