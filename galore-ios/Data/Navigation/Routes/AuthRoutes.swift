//
//  AuthRoutes.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation
import SwiftUI

enum AuthRoutes: Routable {
	case welcome
	case login
	case register
	//	case forgotPassword
	//	case resetPassword(token: String)
	//	case verifyEmail(token: String)
	//	case logout

	
	
	@ViewBuilder
	func viewToDisplay(router: Router<AuthRoutes>) -> some View {
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
