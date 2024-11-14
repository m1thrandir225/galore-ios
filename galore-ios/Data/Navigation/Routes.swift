//
//  AuthRoutes.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation
import SwiftUI

enum Routes: Routable {
	case login
	case register
	case home
	//	case forgotPassword
	//	case resetPassword(token: String)
	//	case verifyEmail(token: String)
	//	case logout
	case welcome
	case help
	case settings
	
	
	@ViewBuilder
	func viewToDisplay(router: Router<Routes>) -> some View {
		switch self {
		case .login:
			LoginScreen(router: router)
		case .register:
			RegisterScreen(router: router)
		case .welcome:
			WelcomeScreen(router: router)
		case .home:
			HomeScreen(router: router)
		case .help:
			HelpScreen(router: router)
		case .settings:
			SettingsScreen(router: router)
		}
	}
	
	var navigationType: NavigationType  {
		switch self  {
		case .login, .register, .welcome, .home, .help:
				.push
		case .settings:
				.fullScreenCover
		}
	}

}
