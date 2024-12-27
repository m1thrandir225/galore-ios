//
//  SetupFlavursViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

@MainActor
class SetupFlavoursViewModel: ObservableObject {
	private final let networkService: NetworkService = .shared
	private final let userRepository: UserRepository = UserRepositoryImpl()
	@Published var flavours: [Flavour]? = nil
	@Published var likedFlavours: Set<String> = []
	@Published var isLoading: Bool = true
	@Published var isSubmitting: Bool = false
	@Published var errorMessage: String? = nil
	
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
	
	func submitLikedFlavours(completionHandler: () -> Void) async throws {
		isSubmitting = true
		defer {
			isSubmitting = false
		}
		do {
			let userId = userRepository.getUserId()
			
			guard let userId else {
				throw UserManagerError.userIdNotFound
			}
			
			let request = LikeFlavours(userId: userId, flavourIds: likedFlavours.compactMap{String($0)})
			let response = try await networkService.execute(request)
			
			completionHandler()
			
		}
		catch let error as NetworkError {
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
		} catch UserManagerError.userIdNotFound {
			errorMessage = "No user found"
		}
		
	}
	
	func addOrRemoveFlavourToLiked(_ flavourId: String) {
		if isFlavourLiked(flavourId) {
			removeFlavourFromLiked(flavourId)
		} else {
			addFlavourToLiked(flavourId)
		}
	}
	
	func addFlavourToLiked(_ flavourId: String) {
		likedFlavours.insert(flavourId)
	}
	
	func removeFlavourFromLiked(_ flavourId: String) {
		likedFlavours.remove(flavourId)
	}
	
	func isFlavourLiked(_ flavourId: String) -> Bool {
		return likedFlavours.contains(flavourId)
	}
	
	func fetchFlavours() async throws {
		
		let request = GetFlavours()
		let response = try await networkService.execute(request)
		
		flavours = response
		
	}
}
