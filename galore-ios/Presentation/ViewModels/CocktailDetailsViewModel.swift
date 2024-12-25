//
//  CocktailDetailsViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 17.12.24.
//
import Foundation
import SwiftUI

@MainActor
class CocktailDetailsViewModel : ObservableObject {
	private var cocktailService: CocktailService = CocktailService.shared
	
	@Published var errorMessage: String?
	@Published var isLoading: Bool = false
	@Published var cocktail: Cocktail? = nil
	@Published var isLikedByUser: Bool? = nil
	@Published var similar: [Cocktail]? = nil
	
	func loadData(for id: String) async {
		isLoading = true
		defer {
			isLoading  = false
		}
		async let fetchIsLiked: () = fetchIsLikedByUser(for: id)
		async let fetchDetails: () = fetchCocktailDetails(for: id)
		async let fetchSimilar: () = fetchSimillarCocktails(for: id)
		
		let(_, _, _) = await (fetchDetails, fetchIsLiked, fetchSimilar)
	}
	
	func fetchCocktailDetails(for id: String) async {
		do {
			let details = try await cocktailService.getCocktail(with: id)
			
			await fetchSimillarCocktails(for: details.id)
			cocktail = details
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func fetchIsLikedByUser(for id: String) async {
		do {
			let status = try await cocktailService.fetchIsCocktailLikedByUser(for: id)
			isLikedByUser = status
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func likeUnlikeCocktail(for id: String, action: LikeUnlikeStatus) async throws {
		do {
			switch action {
			case .like:
				try await cocktailService.likeCocktail(for: id)
				isLikedByUser = true
			case .unlike:
				try await cocktailService.unlikeCocktail(for: id)
				isLikedByUser = false
			}
		} catch {
			errorMessage = error.localizedDescription
		}

	}
	
	func fetchSimillarCocktails(for id: String) async {
		do {
			let details = try await cocktailService.fetchSimilarCocktails(for: id)
			
			similar = details
		} catch {
			errorMessage = error.localizedDescription
		}
	}
}
