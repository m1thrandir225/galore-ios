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
	
	static let baseURL: String = {
		switch environment {
		case .development: return "http://Sebastijans-Macbook-Pro.local:8080"
		case .production: return ""
		}
	}()
	
	static let publicURL: String = {
		return baseURL + "/public"
	}()
	
	static let apiBase: String = {
		return baseURL + "/api/v1"
	}()
}
