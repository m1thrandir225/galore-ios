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
	
	func addOrRemoveFlavourToSelected(_ flavourId: String) {
		if isFlavourSelected(flavourId) {
			removeFlavourFromSelected(flavourId)
		} else {
			addFlavourToSelected(flavourId)
		}
	}
	
	func addFlavourToSelected(_ flavourId: String) {
		selectedFlavours.insert(flavourId)
	}
	
	func removeFlavourFromSelected(_ flavourId: String) {
		selectedFlavours.remove(flavourId)
	}
	
	func isFlavourSelected(_ flavourId: String) -> Bool {
		return selectedFlavours.contains(flavourId)
	}
	
	
	func fetchFlavours() async throws {
		
		let request = GetFlavours()
		let response = try await networkService.execute(request)
		
		flavours = response
		
	}
	
}
