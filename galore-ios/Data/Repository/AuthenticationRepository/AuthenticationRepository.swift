//
//  AuthenticationRepository.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation

protocol AuthenticationRepository {
	func login(email: String, password: String) async throws -> User
	func register(email: String, password: String, name: String, birthday: Date, avatarFileUrl: URL) async throws -> User
	func logout() async throws -> Void
	func refreshToken() async throws -> Void
}
