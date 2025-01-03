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
							.transition(.move(edge: .bottom))
							
					} else {
						TabRoutesView()
							.transition(.move(edge: .bottom))
				
					}
					
				} else {
					AuthRoutesView()
						.transition(.slide)
				}
			}
		}.onAppear {
			Task {
				await authService.checkAuthentication()
			}
		}.animation(.smooth, value: authService.isLoggedIn)
			.animation(.smooth, value: authService.isNewUser)
	}
}

#Preview {
    ContentView()
}
