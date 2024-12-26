//
//  ContentView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 24.10.24.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject private var authService: AuthService
	@State private var isPresented: Bool = false
	
	var body: some View {
		Group {
			if authService.isLoading || authService.isRefreshing {
				LoadingScreen()
			} else {
				if authService.isLoggedIn {
					if authService.isNewUser {
						OnboardingRoutesView()
					} else {
						TabRoutesView()
					}
					
				} else {
					AuthRoutesView()
				}
			}
		}.onAppear {
			Task {
				await authService.checkAuthentication()
			}
		}
	}
}

#Preview {
    ContentView()
}
