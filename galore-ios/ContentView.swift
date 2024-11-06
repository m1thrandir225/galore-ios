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
		RoutingView(Routes.self) { router in
			if authService.isLoading || authService.isRefreshing {
				LoadingScreen()
			} else {
				if authService.isLoggedIn {
					HomeScreen(router: router)
				} else {
					WelcomeScreen(router: router)
				}
			}
		}
		.onAppear {
			Task {
				await authService.checkAuthentication()
			}
		}
		.environmentObject(authService)
    }
}

#Preview {
    ContentView()
}
