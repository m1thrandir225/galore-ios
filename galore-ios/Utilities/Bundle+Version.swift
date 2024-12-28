//
//  Bundle+Version.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//
import Foundation

extension Bundle {
	var releaseVersionNumber: String? {
		return infoDictionary?["CFBundleShortVersionString"] as? String
	}
	var buildVersionNumber: String? {
		return infoDictionary?["CFBundleVersion"] as? String
	}
}
