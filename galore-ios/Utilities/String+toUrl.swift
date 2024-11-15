//
//  File.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 15.11.24.
//


import SwiftUI
import NukeUI

extension String {
	var toUrl: URL? {
		URL(string: self)
	}
}
