//
//  UpdateProfileViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//
import Foundation
import SwiftUI

@MainActor
class UpdateProfileViewModel : ObservableObject {
	private final let userRepository: UserRepository = UserRepositoryImpl()
	private final let networkService: NetworkService = .shared
	@Published var email: String = ""
	@Published var name: String = ""
	@Published var errorMesage: String? = nil
	@Published var birthday: Date?
	@Published var networkFile: NetworkFile? = nil
	@Published var isLoading: Bool = false
	@Published var successMessage: String? = nil
	
	@Published var imageModel: ProfilePictureModel? = nil
	
	func loadInitialData() {
		guard let user = userRepository.getUser() else { errorMesage = "User not found"; return}
		
		email = user.email
		name = user.name
		birthday = user.birthday
	
		if let avatar = user.avatar {
			let imageURL = "\(Config.baseURL)/\(avatar)".toUrl
			imageModel = ProfilePictureModel(networkImageURL: imageURL)
		} else {
			imageModel = ProfilePictureModel()
		}
	}
	
	func updateProfile(completionHandler: @escaping() -> Void) async {
		guard let birthday else { errorMesage = "Please select birthday"; return }
		guard let networkFile else { errorMesage = "Please select profile picture"; return}
		guard let userId = userRepository.getUserId() else { errorMesage = "User not found"; return }
		isLoading = true
		defer {
			isLoading = false
		}
		do {
			let request = UpdateUserProfile(
				userId: userId, email: email, name: name, birthday: birthday, networkFile: networkFile
			)
			
			let response = try await networkService.execute(request)
			
			userRepository.setUser(response)
			
			try? await Task.sleep(for: .seconds(1.5))
			
			completionHandler()
		} catch {
			errorMesage = ""
		}
	}
	
}
