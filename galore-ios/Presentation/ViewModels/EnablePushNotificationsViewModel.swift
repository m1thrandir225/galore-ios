//
//  EnablePushNotificationsViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//
import Foundation
import SwiftUI

enum SendPushNotificationsError: Error {
	case invalidUserId
	case invalidUserPushNotificationSetting
	case unknown
}


@MainActor
class EnablePushNotificationsViewModel : ObservableObject {
	let notificationCenter = UNUserNotificationCenter.current()
	private let networkService: NetworkService = .shared
	private let userRepository: UserRepository = UserRepositoryImpl()
	
	@Published var hasPermission: Bool = false
	@Published var isLoading: Bool = false
	@Published var errorMessage: String? = nil
	
	func enablePushNotifications(_ completionHandler:() -> Void) async throws {
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			try await self.requestNotificationPermission()
			
			if !hasPermission {
				return
			}
			
			let userId = userRepository.getUserId()
			
			guard userId != nil else {
				throw UserManagerError.userIdNotFound
			}
			
			let request = UpdateUserPushNotificationSetting(userId: userId!, status: true)
			let response = try await networkService.execute(request)
			
			if response != true {
				throw SendPushNotificationsError.unknown
			}
			
			completionHandler()
		} catch SendPushNotificationsError.unknown {
			errorMessage = "There was a problem updating your push notification settings."
		}
		
	}
	
	func disablePushNotifications(_ completionHandler:() -> Void) async throws {
		isLoading = true
		
		defer {
			isLoading = false
		}
		
		do {
			let request = UpdateUserPushNotificationSetting(userId: userRepository.getUserId()!, status: false)
			let response = try await networkService.execute(request)
			
			if response != false {
				throw SendPushNotificationsError.unknown
			}
			
			completionHandler()
			
		} catch SendPushNotificationsError.unknown {
			errorMessage = "There was a problem updating your push notification settings."
		}
		
	}
	
	func requestNotificationPermission() async throws {
		let status = try await notificationCenter.requestAuthorization(options: [.alert, .badge, .sound])
		hasPermission = status
	}
	
	func checkNotificationPermission()  {
		self.notificationCenter.getNotificationSettings(completionHandler: { permission in
			switch permission.authorizationStatus {
			case .authorized, .ephemeral:
				self.hasPermission = true
			case .denied, .notDetermined, .provisional:
				self.hasPermission = false
			@unknown default:
				self.hasPermission = false
				
			}
		})
		
		
	}
}
