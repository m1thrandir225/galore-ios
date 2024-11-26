//
//  TabViewRoutes.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI

enum TabRoutes: Routable {
	case home
	case search
	case library
	case generate
	case help
	case settingsOverview
	case updateProfile
	case changePassword

	
	var navigationType: NavigationType  {
		switch self {
		case .generate, .home, .library, .search, .settingsOverview, .updateProfile, .changePassword:
				.push
		case .help:
				.sheet
		}
	}
	
	@ViewBuilder
	func viewToDisplay(router: Router<TabRoutes>) -> some View {
		switch self {
		case .home:
			HomeScreen(router: router)
		case .generate:
			GenerateScreen(router: router)
		case .library:
			LibraryScreen(router: router)
		case .search:
			SearchScreen(router: router)
		case .settingsOverview:
			OverviewSettingsScreen(router: router)
		case .help:
			HelpScreen(router: router)
		case .updateProfile:
			UpdateProfileScreen(router: router)
		case .changePassword:
			ChangePasswordScreen(router: router)
		}
	}
	
}
