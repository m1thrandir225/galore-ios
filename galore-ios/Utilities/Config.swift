//
//  Config.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 21.11.24.
//

enum Environment {
	case development
	case production
}


struct Config {
	static let environment: Environment = .development
	
	static let apiBase: String = {
		switch environment {
		case .development: return "http://localhost:8080/api/v1"
		case .production: return ""
		}
	}()
}
