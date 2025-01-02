//
//  GenerateViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
import Foundation

@MainActor
class GenerateViewModel : ObservableObject {
	private final let userRepository: UserRepository = UserRepositoryImpl()
	private final let networkService: NetworkService = .shared
	
	@Published var generateRequests: [GenerateCocktailRequest]? = nil
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	
	
	func loadData() async {
		isLoading = true
		defer {
			isLoading = false
		}
		
		do {
			async let requests: () = fetchRequests()
			
			let (_) = try await (requests)
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	func refetchData() async {
		guard generateRequests != nil else { return }
		
		do {
			async let requests: () = fetchRequests()
			let (_) = try await (requests)

		} catch {
			errorMessage = error.localizedDescription

		}
	}

	
	func fetchRequests() async throws {
		guard let userId = userRepository.getUserId() else {
			errorMessage = "Missing user id."
			return
		}
		
		let request = GetIncompleteGenerateRequests(userId: userId)
		let response = try await networkService.execute(request)
		
		generateRequests = response
	}
}
