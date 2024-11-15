//
//  Data+String.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 4.11.24.
//
import Foundation

public extension Data {
	mutating func appendString(_ string: String) {
		if let data = string.data(using: .utf8) {
			append(data)
		}
	}
}
