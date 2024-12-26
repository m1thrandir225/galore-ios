//
//  ResetPasswordViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

class ResetPasswordViewModel: ObservableObject {
	@Published var newPassword: String = ""
	@Published var confirmPassword: String = ""
	@Published var errorMessage: String?
	@Published var isLoading: Bool = false
	

	func isValid() -> Bool {
		newPassword.count >= 8 && newPassword == confirmPassword
	}
	
	func resetPassword(completionHandler: @escaping () -> Void) {
		completionHandler()
	}
}
