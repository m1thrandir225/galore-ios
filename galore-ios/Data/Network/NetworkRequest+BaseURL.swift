//
//  NetworkRequest+BaseURL.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 22.11.24.
//

import Foundation

extension NetworkRequest {
	var baseURL: URL {
		Config.apiBase.toUrl!
	}
}
