//
//  NotificationSettingsViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//
import Foundation

@MainActor
class NotificationSettingsViewModel: ObservableObject {
	private final let userRepository: UserRepository = UserRepositoryImpl()
	private final let authSerice: AuthService = .shared
	private final let networkService: NetworkService = .shared
	
	@Published var pushNotificationsEnabled: Bool? = false
	@Published var emailNotificationsEnabled: Bool? = false
	@Published var errorMessage: String? = nil
	@Published var isLoading: Bool = false
	@Published var successMessage: String?
	
	func fetchNotificationSettings() {
		isLoading = true
		defer {
			isLoading = false
		}
		do {
			guard let user = userRepository.getUser() else { throw UserManagerError.noUserFound }
			
			pushNotificationsEnabled = user.enabledPushNotifications
			emailNotificationsEnabled = user.enabledEmailNotifications
			
		} catch {
			errorMessage = error.localizedDescription
		}
		
	}
	
	func updateNotificationSettings(completionHandler: @escaping() -> Void) async {
		guard let emailNotificationsEnabled else { return }
		guard let pushNotificationsEnabled else { return }
		
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			async let updatePush: () = updatePushNotifications(status: pushNotificationsEnabled)
			async let updateEmail: () = updateEmailNotifications(status: emailNotificationsEnabled)
			
			let (_, _) = try await (updatePush, updateEmail)
			let user =  try await authSerice.fetchUser()
			userRepository.setUser(user)
			successMessage = "Preferences updated"
			
			try? await Task.sleep(nanoseconds: 1500000000)
			completionHandler()
			
			
		} catch let error as NetworkError {
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
			errorMessage = error.localizedDescription
		}
	}
	
	func updateEmailNotifications(status: Bool) async  throws {
		
		guard let userId = userRepository.getUserId() else { throw UserManagerError.userIdNotFound }
		let request = UpdateUserEmailNotificationSetting(userId: userId, status: status)
		
		_ = try await networkService.execute(request)
		
	}
	
	func updatePushNotifications(status: Bool) async  throws {
		
		guard let userId = userRepository.getUserId() else { throw UserManagerError.userIdNotFound }
		let request = UpdateUserPushNotificationSetting(userId: userId, status: status)
		
		_ = try await networkService.execute(request)
		
	}
	
	
}
