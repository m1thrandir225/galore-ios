//
//  galore_iosApp.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 24.10.24.
//

import SwiftUI
import FirebaseCore
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
	func application(_ application: UIApplication,
					 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		FirebaseApp.configure()
		Messaging.messaging().delegate = self
		UNUserNotificationCenter.current().delegate = self
		
		
		return true
	}
	
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		Messaging.messaging().apnsToken = deviceToken
	}
	
	
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
		if let fcm = Messaging.messaging().fcmToken {
			print("fcm", fcm)
		}
	}
}

@main
struct galore_iosApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(AuthService.shared)
		}
	}
}
