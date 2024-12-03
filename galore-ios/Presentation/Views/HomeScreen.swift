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
	
	let columns = [GridItem(.fixed(180)), GridItem(.fixed(180))]
	
	
	var body: some View {
		ScrollView {
//			Button {
//				router.routeTo(.help)
//			} label: {
//				Text("Help")
//			}
//			Button(action: {
//				Task {
//					try await viewModel.logout()
//				}
//			}) {
//				Text("Logout")
//			}
			CocktailGrid(items: $viewModel.results) {
				print("item clicked")
			}
		}
		.background(Color(.background))
		.onAppear {
			Task {
				await viewModel.getCocktails()
			}
		}
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	HomeScreen(router: router)
}
