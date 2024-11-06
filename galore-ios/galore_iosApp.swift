//
//  galore_iosApp.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 24.10.24.
//

import SwiftUI

@main
struct galore_iosApp: App {
	@StateObject private var authService = AuthService.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(authService)
        }
    }
}
