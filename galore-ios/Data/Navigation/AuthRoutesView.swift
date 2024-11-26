//
//  AuthRoutesView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI

struct AuthRoutesView : View {
	var body: some View {
		RoutingView(AuthRoutes.self) { router in
			WelcomeScreen(router: router)
		}
		
	}
}
