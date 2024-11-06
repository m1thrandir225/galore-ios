//
//  LogoutResponse.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

struct LogoutResponse: Codable {
	let message: String
	
	enum CodingKeys: String, CodingKey {
		case message = "message"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		message = try container.decode(String.self, forKey: .message)
	}
}
