//
//  Router.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import SwiftUI


public class Router<Destination: Routable>: ObservableObject {
	/// Used to programatically control a navigation stack
	@Published public var path: NavigationPath = NavigationPath()
	/// Used to present a view using a sheet
	@Published public var presentingSheet: Destination?
	/// Used to present a view using a full screen cover
	@Published public var presentingFullScreenCover: Destination?
	/// Used by presented Router instances to dismiss themselves
	@Published public var isPresented: Binding<Destination?>
	
	private var stack: [Destination] = []
	
	public var isPresenting: Bool {
		presentingSheet != nil || presentingFullScreenCover != nil
	}
	
	
	public init(isPresented: Binding<Destination?>) {
		self.isPresented = isPresented
	}
	
	/// Returns the view associated with the specified `Routable`
	@ViewBuilder public func view(for route: Destination) -> some View {
		route.viewToDisplay(router: router(routeType: route.navigationType))
	}
	
	/// Routes to the specified `Routable`.
	public func routeTo(_ route: Destination) {
		switch route.navigationType {
		case .push:
			push(route)
		case .sheet:
			presentSheet(route)
		case .fullScreenCover:
			presentFullScreen(route)
		}
	}
	func popUntil(_ destination: Destination) {
		while let last = stack.last, last != destination {
			stack.removeLast()
		}
		path = NavigationPath(stack)
	}
	
	func replaceStack(with destination: Destination) {
		stack = [destination]
		path = NavigationPath(stack) // Replace current stack with a single destination
	}
	
	public func replace(_ route: Destination) {
		switch route.navigationType {
		case .push:
			if !stack.isEmpty && !path.isEmpty {
				stack.removeLast()
				path.removeLast()
			}
			push(route)
		case .sheet:
			presentSheet(route)
		case .fullScreenCover:
			presentFullScreen(route)
		}
	}
	
	// Pop to the root screen in our hierarchy
	public func popToRoot() {
		stack.removeLast(stack.count)
		path = NavigationPath(stack)
	}
	
	
	// Dismisses presented screen or self
	public func dismiss() {
		if !stack.isEmpty {
			stack.removeLast()
			path = NavigationPath(stack)
			
		} else if presentingSheet != nil {
			presentingSheet = nil
		} else if presentingFullScreenCover != nil {
			presentingFullScreenCover = nil
		} else {
			isPresented.wrappedValue = nil
		}
	}
	
	private func push(_ appRoute: Destination) {
		stack.append(appRoute)
		path.append(appRoute)
	}
	
	private func presentSheet(_ route: Destination) {
		self.presentingSheet = route
	}
	
	private func presentFullScreen(_ route: Destination) {
		self.presentingFullScreenCover = route
	}
	
	// Return the appropriate Router instance based
	// on `NavigationType`
	private func router(routeType: NavigationType) -> Router {
		switch routeType {
		case .push:
			return self
		case .sheet:
			return Router(
				isPresented: Binding(
					get: { self.presentingSheet },
					set: { self.presentingSheet = $0 }
				)
			)
		case .fullScreenCover:
			return Router(
				isPresented: Binding(
					get: { self.presentingFullScreenCover },
					set: { self.presentingFullScreenCover = $0 }
				)
			)
		}
	}
}
