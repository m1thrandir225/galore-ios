//
//  ForgotPasswordViewModel.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import Foundation

class ForgotPasswordViewModel: ObservableObject {
	private final let networkService: NetworkService = .shared

	@Published var email: String = ""
	@Published var code: String = ""
	@Published var isLoading: Bool = false
	@Published var error: String? = nil
	@Published var passwordChangeRequest: String? = nil
}

