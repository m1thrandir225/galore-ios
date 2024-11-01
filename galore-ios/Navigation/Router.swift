//
//  Router.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import SwiftUI

final class Router: ObservableObject {
	
	@Published var path = NavigationPath()

	public enum Destination: Codable, Hashable {
		case home
		case welcome
		case login
		case register
	}
	
	@ViewBuilder func view(for route: Destination) -> some View {
		switch route {
		case .home:
			HomeScreen()
		case .welcome:
			WelcomeScreen()
		case .login:
			LoginScreen()
		case .register:
			RegisterScreen()
		}
	}
	
	func navigate(destination: Destination) {
		path.append(destination)
	}
	
	func replaceCurrent(destination: Destination) {
		path.removeLast()
		path.append(destination)
	}
	
	func navigateBack() {
		path.removeLast()
	}
	
	func navigateToRoot() {
		path.removeLast(path.count)
	}
}
