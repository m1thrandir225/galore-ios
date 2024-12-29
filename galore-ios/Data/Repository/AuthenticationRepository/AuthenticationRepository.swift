//
//  AuthenticationRepository.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation

protocol AuthenticationRepository {
	func login(with response: LoginResponse)
	func register(with response: RegisterResponse)
	func logout()
	func deleteAccount()
	func shouldRefreshToken() -> Bool
	func isAuthenticated() -> Bool
	func getSessionToken() -> String?
	func getRefreshToken() -> String?
	func getAccessToken() -> String?
	func setAccessToken(_ accessToken: String)
}
