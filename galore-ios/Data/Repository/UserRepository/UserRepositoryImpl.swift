//
//  UserRepositoryImpl.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation

@MainActor
final class UserRepositoryImpl: UserRepository {
	private let userManager: UserManager = UserManager.shared
	
	func getUserDetails() async throws -> User {
		guard let user = userManager.user else {
			throw UserManagerError.noUserFound
		}
		return user
	}
	
}
