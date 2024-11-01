//
//  Router.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import SwiftUI

public class Router<Destination: Routable> : ObservedObject {
	@Published public var path: NavigationPath = NavigationPath()
	
}
