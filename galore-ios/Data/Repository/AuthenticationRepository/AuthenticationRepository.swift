//
//  AuthenticationRepository.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation

protocol AuthenticationRepository {
	func login(email: String, password: String) async throws
	func register(email: String, password: String, name: String, birthday: Date, networkFile: NetworkFile) async throws
	func logout() async throws
}
