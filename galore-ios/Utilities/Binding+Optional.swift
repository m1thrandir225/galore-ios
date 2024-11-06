//
//  Binding+Optional.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation
import SwiftUI

public extension Binding where Value: Equatable {
	init(_ source: Binding<Value>, deselectTo value: Value) {
		self.init(get: { source.wrappedValue },
				  set: { source.wrappedValue = $0 == source.wrappedValue ? value : $0 }
		)
	}
}
