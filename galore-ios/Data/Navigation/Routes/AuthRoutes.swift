//
//  AuthRoutes.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation
import SwiftUI

struct ResetPasswordArgs : Equatable {
	static func == (lhs: ResetPasswordArgs, rhs: ResetPasswordArgs) -> Bool {
		lhs.resetPasswordRequest.id == rhs.resetPasswordRequest.id
	}
	
	let resetPasswordRequest: ResetPasswordModel
}

enum AuthRoutes: Routable {
	case welcome
	case login
	case register
	case forgotPassword
	case resetPassword(ResetPasswordArgs)
	//	case verifyEmail(token: String)

	enum RouteArgs {
		case none
		case resetPassword(ResetPasswordArgs)
	}
	
	var arguments: RouteArgs {
		switch self {
		case .resetPassword(let args):
			return .resetPassword(args)
		default:
			return .none
		}
	}
	
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
		case .resetPassword(let args):
			ResetPasswordScreen(router: router, resetPasswordRequest: args.resetPasswordRequest)
		}
	}
	
	var navigationType: NavigationType  {
		switch self  {
		case .login, .register, .welcome, .forgotPassword, .resetPassword:
				.push
		}
	}

}
