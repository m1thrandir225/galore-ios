//
//  SearchScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI

struct SearchScreen: View {
	@StateObject  var router: Router<TabRoutes>
	@StateObject var viewModel: SearchScreenViewModel = SearchScreenViewModel()
	
	@State var searchText: String = ""
	
	@FocusState private var focus: Field?
	
	private enum Field: Int, Hashable, CaseIterable {
		case search
	}
	
	init(router: Router<TabRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
	
	var body: some View {
		VStack {
			HStack {
				if viewModel.hasSearchResults {
					Button {
						Task {
							await viewModel.searchCocktail(with: nil)
							searchText = ""
						}
					} label: {
						Image(systemName: "xmark.circle")
							.resizable()
							.frame(width: 24, height: 24)
							.foregroundStyle(Color("MainColor"))
							.background(Color("Background"))
							.symbolEffect(.bounce.wholeSymbol, options: .repeat(1))
					}.transition(.move(edge: .leading).combined(with: .opacity))
				}
				TextField("Search", text: $searchText)
					.padding(10)
					.overlay(
						RoundedRectangle(cornerRadius: 16)
							.stroke(Color("Outline"), lineWidth: 1.5)
					)
					.keyboardType(.default)
					.autocapitalization(.words)
					.focused($focus, equals: Field.search)
				if !searchText.isEmpty {
					Button {
						Task {
							await viewModel.searchCocktail(with: searchText)
						}
					} label: {
						Image(systemName: "magnifyingglass.circle.fill")
							.resizable()
							.frame(width: 32, height: 32)
							.foregroundStyle(Color("MainColor"))
							.background(Color("Background"))
							.symbolEffect(.bounce.wholeSymbol, options: .repeat(1))
					}.transition(.move(edge: .trailing).combined(with: .opacity))
				}
				
			}.padding()
				.animation(.easeInOut, value: viewModel.hasSearchResults)
				.animation(.easeInOut, value: searchText.isEmpty)
			
			ScrollView(showsIndicators: false) {
				CocktailGrid(items: $viewModel.results, onCardPress: {
					
				})
				.animation(.easeInOut, value: viewModel.results)
			}
			
		}.background(Color.background)
	}
	
}



#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	SearchScreen(router: router)
}
