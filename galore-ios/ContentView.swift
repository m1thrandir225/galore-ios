//
//  ContentView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 24.10.24.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var authService: AuthService
	
	
	var body: some View {
		Group {
			if authService.isLoading || authService.isRefreshing {
				LoadingScreen()
			} else {
				if authService.isLoggedIn {
					RoutingView(Routes.self) { router in
						HomeScreen(router: router)
					}
				} else {
					RoutingView(Routes.self) { router in
						WelcomeScreen(router: router)
					}
				}
			}
		}.onAppear {
			Task {
				try await authService.checkAuthentication()
			}
		}
	}
}

#Preview {
    ContentView()
}
