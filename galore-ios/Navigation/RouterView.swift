//
//  RouterView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//
import SwiftUI
struct RouterView<Content: View> : View {
	@StateObject var router: Router = Router()
	private let content: Content
	
	
	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content()
	}
	
	var body: some View {
		NavigationStack(path: $router.path) {
			content
				.navigationDestination(for: Router.Destination.self) { route in
					router.view(for: route)
				}
		}
	}
	
}
