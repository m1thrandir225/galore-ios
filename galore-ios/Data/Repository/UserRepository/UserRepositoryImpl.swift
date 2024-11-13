//
//  UserRepositoryImpl.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation


final class UserRepositoryImpl: UserRepository {
	private let userManager: UserManager = UserManager.shared
	
	func getUser() -> User? {
		return userManager.user
	}
	func saveUser(of user: User) throws -> User {
		userManager.setUser(user)
		
		return user
	}
	
	func getUserId() -> String? {
		return userManager.userId
	}
	
}
