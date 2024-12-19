//
//  Routable.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import Foundation
import SwiftUI

public enum NavigationType {
	case push
	case sheet
	case fullScreenCover
}

public protocol Routable: Hashable, Identifiable {
	associatedtype ViewType: View
	associatedtype RouteArgs = Void
	
	var navigationType: NavigationType { get }
	func viewToDisplay(router: Router<Self>) -> ViewType
}

extension Routable {
	public var id: Self { self }
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
