//
//  GenerateFlavourSelectionViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.1.25.
//
import Foundation

@MainActor
class GenerateFlavourSelectionViewModel : ObservableObject {
	private final let networkService: NetworkService = .shared
	@Published var selectedFlavours: Set<String> = []
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	@Published var flavours: [Flavour]? = nil
	
	func loadData() async {
		isLoading = true
		defer {
			isLoading = false
		}
		do {
			async let flavours: () = fetchFlavours()
			
			let (_) = try await (flavours)
			
		} catch {
			errorMessage = "There was an error fetching flavours."
		}
	}
	
	func addOrRemoveFlavourToSelected(_ flavourName: String) {
		if isFlavourSelected(flavourName) {
			removeFlavourFromSelected(flavourName)
		} else {
			addFlavourToSelected(flavourName)
		}
	}
	
	func addFlavourToSelected(_ flavourName: String) {
		selectedFlavours.insert(flavourName)
	}
	
	func removeFlavourFromSelected(_ flavourName: String) {
		selectedFlavours.remove(flavourName)
	}
	
	func isFlavourSelected(_ flavourName: String) -> Bool {
		return selectedFlavours.contains(flavourName)
	}
	
	
	func fetchFlavours() async throws {
		
		let request = GetFlavours()
		let response = try await networkService.execute(request)
		
		flavours = response
		
	}
	
}
