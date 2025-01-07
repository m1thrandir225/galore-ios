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
	static let environment: Environment = .production
	
	static let baseURL: String = {
		switch environment {
		case .development: return "http://localhost:9090"
		case .production: return "http://galore-services.sebastijanzindl.me"
		}
	}()
	
	static let publicURL: String = {
		return baseURL + "/public"
	}()
	
	static let apiBase: String = {
		return baseURL + "/api/v1"
	}()
}
