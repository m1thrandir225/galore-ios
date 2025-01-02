//
//  GenerateCocktailDetailsScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
import Foundation

@MainActor
class GenerateCocktailDetailsViewModel : ObservableObject {
	private final let networkService : NetworkService = .shared
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	@Published var cocktail: GeneratedCocktail? = nil
	
	func loadData(for id: String) async {
		isLoading = true
		defer {
			isLoading = false
		}
		
		do {
			async let fetchDetails: () = fetchDetails(for: id)
			
			let (_) = try await (fetchDetails)
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func fetchDetails(for id: String) async throws {
		let request = GetGeneratedCocktail(cocktailId: id)
		let response = try await networkService.execute(request)
		
		cocktail = response
	}
}
