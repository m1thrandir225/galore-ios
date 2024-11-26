//
//  HomeView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import SwiftUI

struct HomeScreen: View {
	@StateObject var router: Router<TabRoutes>
	
	@StateObject var viewModel: HomeViewModel = HomeViewModel()
	
	var body: some View {
		ScrollView {
			Button {
				router.routeTo(.help)
			} label: {
				Text("Help")
			}
			Button(action: {
				Task {
					try await viewModel.logout()
				}
			}) {
				Text("Logout")
			}
			if let cocktails = viewModel.cocktails {
				CocktailGrid(items: cocktails, title: "Items", onCardPress: {})
			}
		}.onAppear {
			Task {
				try await viewModel.getHomeScreen()
			}
		}
		
		
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	HomeScreen(router: router)
}
