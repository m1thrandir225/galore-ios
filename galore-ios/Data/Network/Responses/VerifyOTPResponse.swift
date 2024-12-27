//
//  VerifyOTPResponse.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
struct VerifyOTPResponse: Codable {
	let email: String
	let resetPasswordRequest: ResetPasswordModel
	
	private enum CodingKeys: String, CodingKey {
		case email = "email"
		case resetPasswordRequest = "reset_password_request"
	}
	
	init (email: String, resetPasswordRequest: ResetPasswordModel) {
		self.email = email
		self.resetPasswordRequest = resetPasswordRequest
	}
	
	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.email = try container.decode(String.self, forKey: .email)
		self.resetPasswordRequest = try container.decode(ResetPasswordModel.self, forKey: .resetPasswordRequest)
	}
}
