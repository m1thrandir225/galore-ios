//
//  CocktailDetailsScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 17.12.24.
//
import SwiftUI

struct CocktailDetailsScreen : View {
	@StateObject var router: Router<TabRoutes>
	@StateObject var viewModel: CocktailDetailsViewModel = CocktailDetailsViewModel()
	
	let cocktailId: String
	
	init(router: Router<TabRoutes>, cocktailId: String) {
		_router = StateObject(wrappedValue: router)
		self.cocktailId = cocktailId
	}

	var body: some View {
		VStack {
			if viewModel.isLoading {
				ProgressView()
			} else {
				if let cocktail = viewModel.cocktail {
					Text(cocktail.id)
					Text(cocktail.name)
				}
			}
		}.background(Color.background)
			.onAppear {
				Task {
					await viewModel.fetchCocktailDetails(for: cocktailId)
				}
			}
		
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	CocktailDetailsScreen(router: router, cocktailId: "hello")
}
