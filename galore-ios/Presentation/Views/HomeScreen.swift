//
//  HomeView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.11.24.
//

import SwiftUI

struct HomeScreen: View {
	@StateObject var router: Router<Routes>
	
	@StateObject var viewModel: HomeViewModel = HomeViewModel(authenticationRepository: AuthenticationRepositoryImpl())
	
    var body: some View {
		Button(action: {
			Task {
				try await viewModel.logout()
			}
		}) {
			Text("Logout")
		}
    }
}

#Preview {
	@Previewable @State  var route: Routes? = nil
	let router = Router<Routes>(isPresented: Binding(projectedValue: $route))
	HomeScreen(router: router)
}
