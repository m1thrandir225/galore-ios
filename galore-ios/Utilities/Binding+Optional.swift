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

extension Binding {
	func optionalBinding<T>() -> Binding<T>? where T? == Value {
		if let wrappedValue = wrappedValue {
			return Binding<T>(
				get: { wrappedValue },
				set: { self.wrappedValue = $0 }
			)
		} else {
			return nil
		}
	}
}
