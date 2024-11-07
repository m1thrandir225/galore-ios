//
//  RegisterViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation
import SwiftUI

@MainActor
class RegisterViewModel: ObservableObject {
	@Published var name: String = ""
	@Published var email: String = ""
	@Published var password: String = ""
	@Published var birthday: Date?
	@Published var avatarURL: URL?
	
	var canContinueToPersonalization: Bool {
		!name.isEmpty && !email.isEmpty && !password.isEmpty
	}
	
	var canContinueToRegistration: Bool {
		canContinueToPersonalization && birthday != nil && avatarURL != nil
	}
	
	func canContinue(step: RegisterStep) -> Bool {
		switch step {
		case .info:
			return canContinueToPersonalization
		case .personalization:
			return canContinueToRegistration
		}
	}
	
	func register() {
		//TODO: implement
	}
}
