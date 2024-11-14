//
//  UserMenuSheetViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//
import Foundation
import SwiftUI

@MainActor
class UserMenuSheetViewModel: ObservableObject {
	private var repository: UserRepository = UserRepositoryImpl()
	private var authService: AuthService = AuthService.shared
	
	@Published var user: User? = nil
	
	func getUser() {
		user = repository.getUser()
	}
	
	func logout() async  {
		do {
			try await authService.logout()
		} catch {
			
		}
	}
	
}
