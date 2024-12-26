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
	case forgotPassword
	case resetPassword
	//	case verifyEmail(token: String)

	
	
	@ViewBuilder
	func viewToDisplay(router: Router<AuthRoutes>) -> some View {
		switch self {
		case .login:
			LoginScreen(router: router)
		case .register:
			RegisterScreen(router: router)
		case .welcome:
			WelcomeScreen(router: router)
		case .forgotPassword:
			ForgotPasswordScreen(router: router)
		case .resetPassword:
			ResetPasswordScreen(router: router)
		}
	}
	
	var navigationType: NavigationType  {
		switch self  {
		case .login, .register, .welcome, .forgotPassword, .resetPassword:
				.push
		}
	}

}
