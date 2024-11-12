//
//  HomeView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import SwiftUI

struct HomeScreen: View {
	@StateObject var router: Router<Routes>
	
	@StateObject var viewModel: HomeViewModel = HomeViewModel()
	
    var body: some View {
		GeometryReader { geometry in
			VStack(alignment: .center) {
				AppHeader(openMenu: {
					router.routeTo(Routes.menu)
				})
				.padding([.top], geometry.safeAreaInsets.top)
				ScrollView {
					Button(action: {
						Task {
							try await viewModel.logout()
						}
					}) {
						Text("Logout")
					}
				}
			}.ignoresSafeArea(.all)
		}
    }
}

#Preview {
	@Previewable @State  var route: Routes? = nil
	let router = Router<Routes>(isPresented: Binding(projectedValue: $route))
	HomeScreen(router: router)
}
