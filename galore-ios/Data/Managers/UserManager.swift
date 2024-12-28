//
//  UserManager.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//

import Foundation

enum UserManagerError: Error {
	case noUserFound
	case updateUserFailed
	case failedFetchingUser
	case failedDecodingUser
	case failedFetchingUserImage
	case userIdNotFound
}

class UserManager {
	static let shared = UserManager()
	
	private let userDefaults = UserDefaults.standard
	private let userIdKey: String = "userId"
	
	private init() {}
	
	var userId: String? {
		get { userDefaults.string(forKey: userIdKey)}
		set { userDefaults.setValue(newValue, forKey: userIdKey) }
	}
	
	private(set) var user: User?
	
	private(set) var categoriesForUser: [Category]?
	private(set) var likedFlavours: [Flavour]?
	
	func setCategoriesForUser(_ categories: [Category]) {
		self.categoriesForUser = categories
	}
	
	func setLikedFlavours(_ flavours: [Flavour]) {
		self.likedFlavours = flavours
	}
	
	func clearLikedFlavours() {
		self.likedFlavours = nil
	}
	
	func clearCategoriesForUser() {
		self.categoriesForUser = nil
	}
	
	func setUser(_ user: User) {
		self.user = user
		self.userId = user.id
	}
	
	func clearUser() {
		self.user = nil
	}
	
}
