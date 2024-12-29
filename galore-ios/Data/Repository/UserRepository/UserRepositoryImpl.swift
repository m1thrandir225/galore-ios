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
	
	
	func setUser(_ user: User) {
		userManager.setUser(user)
	}
	
	
	func getUserId() -> String? {
		return userManager.userId
	}
	
	func setUserId(_ userId: String) {
		userManager.userId = userId
	}
	
	func getLikedFlavoursForUser() -> [Flavour]? {
		return userManager.likedFlavours
	}
	
	func setCategoriesForUser(_ categories: [Category]) {
		userManager.setCategoriesForUser(categories)
	}
	
	func getCategoriesForUser() -> [Category]? {
		return userManager.categoriesForUser
	}
	
	func setLikedFlavoursForUser(_ likedFlavours: [Flavour]) {
		userManager.setLikedFlavours(likedFlavours)
	}
	
	func clearUser() {
		userManager.clearUser()
		userManager.clearLikedFlavours()
		userManager.clearCategoriesForUser()
	}

	
}
