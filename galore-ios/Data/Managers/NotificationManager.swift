//
//  NotificationManager.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
import Foundation
import UserNotifications


@MainActor
class NotificationManager: ObservableObject{
	@Published private(set) var hasPermission = false
	
	init() {
		Task{
			await getAuthStatus()
		}
	}
	
	func request() async{
		do {
			try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
			 await getAuthStatus()
		} catch{
			print(error)
		}
	}
	
	func getAuthStatus() async {
		let status = await UNUserNotificationCenter.current().notificationSettings()
		switch status.authorizationStatus {
		case .authorized, .ephemeral, .provisional:
			hasPermission = true
		default:
			hasPermission = false
		}
	}
}
