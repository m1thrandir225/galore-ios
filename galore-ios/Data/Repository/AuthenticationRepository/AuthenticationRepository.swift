//
//  AuthenticationRepository.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation

protocol AuthenticationRepository {
	func login(with response: LoginResponse) async throws
	func register(with response: RegisterResponse) async throws
	func logout() async throws
	func shouldRefreshToken() -> Bool
	func isAuthenticated() -> Bool
	func getSessionToken() -> String?
	func getRefreshToken() -> String?
	func getAccessToken() -> String?
	func setAccessToken(_ accessToken: String)
	func getUserId() -> String?
	func setUser(_ user: User)
	func setCategoriesForUser(_ categories: [Category])
}
