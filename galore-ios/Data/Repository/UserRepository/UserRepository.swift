//
//  UserRepository.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

protocol UserRepository {
	func getUser() -> User?
	func setUser(_ user: User)
	func getUserId()-> String?
	func setUserId(_ userId: String)
	func getLikedFlavoursForUser() -> [Flavour]?
	func getCategoriesForUser() -> [Category]?
	func setCategoriesForUser(_ categories: [Category])
	func setLikedFlavoursForUser(_ likedFlavours: [Flavour])
	func clearUser()
}
