//
//  OnboardingRoutes.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//
import Foundation
import SwiftUI

enum OnboardingRoutes : Routable {
	case showcase
	case setupFlavours
	case enableNotifications
	case allDone
	
	@ViewBuilder
	func viewToDisplay(router: Router<OnboardingRoutes>) -> some View {
		switch self {
		case .showcase:
			ShowcaseScreen(router: router)
		case .enableNotifications:
			EnablePushNotificationsScreen(router: router)
		case .setupFlavours:
			SetupFlavoursScreen(router: router)
		case .allDone:
			Text("All Done")
		}
	}
	
	var navigationType: NavigationType {
		switch self {
		case .allDone, .enableNotifications, .setupFlavours, .showcase:
				.push
		}
	}
	
}
