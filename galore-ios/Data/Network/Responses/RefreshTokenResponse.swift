//
//  RefreshTokenResponse.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

struct RefreshTokenResponse: Codable {
	let accessToken: String
	
	init(accessToken: String) {
		self.accessToken = accessToken
	}
	
	enum CodingKeys: String, CodingKey {
		case accessToken = "access_token"
	}

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.accessToken = try container.decode(String.self, forKey: .accessToken)
	}
	
}
