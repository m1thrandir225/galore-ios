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
	//	case forgotPassword
	//	case resetPassword(token: String)
	//	case verifyEmail(token: String)
	//	case logout
	case welcome
	
	@ViewBuilder
	func viewToDisplay(router: Router<Routes>) -> some View {
		switch self {
		case .login:
			LoginScreen(router: router)
		case .register:
			RegisterScreen(router: router)
		case .welcome:
			WelcomeScreen(router: router)
		}
	}
	
	var navigationType: NavigationType  {
		switch self  {
		case .login, .register, .welcome:
				.push
		}
	}
}
