//
//  OnboardingRoutesView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//
import SwiftUI

struct OnboardingRoutesView : View {
	var body: some View {
		RoutingView(OnboardingRoutes.self) { router in
			ShowcaseScreen(router: router)
		}
	}
}
