//
//  GenerateCocktailSelectionViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.1.25.
//
import Foundation

@MainActor
class GenerateCocktailSelectionViewModel : ObservableObject {
	private let cocktailService: CocktailService = .shared
	private let networkService: NetworkService = .shared
	
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	@Published var selectedCocktails: Set<String> = []
	@Published var searchString: String = ""
	@Published var cocktails: [Cocktail] = []
	@Published var hasSearchResults: Bool = false
	
	func loadData() async {
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			cocktails = try await self.cocktailService.searchCocktails()
		} catch {
			errorMessage = error.localizedDescription
		}
		
		
	}
	
	func createGenerateRequest(selectedFlavours: [String], completionHandler: @escaping () -> Void ) async {
		isLoading = true
		defer {
			isLoading = false
		}
		do {
			let cocktailsList = selectedCocktails.compactMap{ String($0) }
			
			let request = CreateGenerateCocktailRequest(referenceCocktailNames: cocktailsList, referenceFlavourNames: selectedFlavours)
			let _ = try await networkService.execute(request)
			
			completionHandler()
		}  catch let error as NetworkError {
			switch error {
			case .badRequest(let message):
				errorMessage = message ?? "Something went wrong"
			case .notFound(let message):
				errorMessage = message ?? "Something went wrong"
			case .unauthorized(let message):
				errorMessage = message ?? "Something went wrong"
			case .serverError(let message):
				errorMessage = message ?? "Something went wrong"
			case .requestFailed(let message):
				errorMessage = message ?? "Something went wrong"
			default:
				errorMessage = "Something went wrong"
			}
		} catch {
			
		}
	}
	
	
	
	func addOrRemoveToSelected( name: String) {
		if isCocktailSelected(name) {
			removeCocktailToSelected(name)
		} else {
			addCocktailToSelected(name)
		}
	}
	
	func isCocktailSelected(_ name: String) -> Bool {
		return selectedCocktails.contains(name)
	}
	
	
	func addCocktailToSelected(_ name: String){
		selectedCocktails.insert(name)
	}
	
	func removeCocktailToSelected(_ name: String) {
		selectedCocktails.remove(name)
	}
	
	func searchCocktail(with query: String? = nil) async {
		isLoading = true
		defer {
			isLoading = false
			hasSearchResults = query != nil
		}
		
		do {
			let results = try await cocktailService.searchCocktails(query: query)
			
			cocktails = results
		} catch {
			errorMessage = error.localizedDescription
		}
	}
}
