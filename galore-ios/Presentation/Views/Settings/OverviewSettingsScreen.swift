//
//  SettingsScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 14.11.24.
//

import SwiftUI

struct OverviewSettingsScreen: View {
	@StateObject  var router: Router<TabRoutes>
	
	init(router: Router<TabRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
	let columns = [GridItem(.fixed(150)), GridItem(.fixed(150))]
	
	var body: some View {
		List {
			Button {
				router.routeTo(.settingsOverview)
			} label: {
				Text("Update Profile")
			}
			
			Button {
				router.routeTo(.help)
			} label: {
				Text("Change Password")
			}
			
			Button {
				router.routeTo(.help)
			} label: {
				Text("Terms and Conditions")
			}
		}.background(Color("Background"))
			.navigationTitle("Settings")
			.navigationBarTitleDisplayMode(.large)
		
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	OverviewSettingsScreen(router: router)
}
