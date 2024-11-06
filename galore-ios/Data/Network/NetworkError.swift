//
//  NetworkError.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation

enum NetworkError: Error {
	case invalidURL
	case requestFailed
	case decodingFailed
	case missingFiles
	case unknown(Error)
}
