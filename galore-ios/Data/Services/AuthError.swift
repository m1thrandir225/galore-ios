//
//  AuthError.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//


import Foundation

enum AuthError: Error {
	case invalidCredentials
	case invalidToken
	case invalidRefreshToken
	case userExists
	case tokenExpired
	case unknownError
}