//
//  UserRepository.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

protocol UserRepository {
	func getUserDetails(userId: String) async throws -> User
	func getUserLikedFlavours(userId: String) async throws -> [Flavour]
	func getUserLikedCocktails(userId: String) async throws -> [Cocktail]
	func updateUserInformation() async throws -> User
	func updateUserPassword() async throws -> Void
	func updateUserEnabledEmailNotifications() async throws -> Bool
	func updateUserEnabledPushNotifications() async throws -> Bool
}
