//
//  HomeViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 8.11.24.
//
import Foundation

@MainActor
class HomeViewModel: ObservableObject {
	private var authService: AuthService = .shared
	private var networkService: NetworkService = .shared
	
	@Published var errorMessage: String?
	@Published var cocktails: [Cocktail]? = nil
 
	
	func logout() async throws {
		do {
			try await authService.logout()
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func getHomeScreen() async throws {
		do {
			let request = ListCocktailsRequest()
			let response = try await networkService.execute(request)
			cocktails = response
			
		} catch {
			errorMessage = error.localizedDescription
		}
	}

}
