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
		ScrollView {
			HStack {
				TextField("Search", text: $searchText)
					.padding(20)
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
							await viewModel.searchCocktails(query: searchText)
						}
					} label: {
						Image(systemName: "magnifyingglass.circle.fill")
							.resizable()
							.frame(width: 38, height: 38)
							.foregroundStyle(Color("MainColor"))
							.background(Color("Background"))
							.symbolEffect(.bounce.wholeSymbol, options: .repeat(1))
					}.transition(.move(edge: .trailing).combined(with: .opacity))
				}
			}.padding()
			.animation(.easeInOut, value: searchText)
			
			if let errorMessage = viewModel.errorMessage {
				Text(errorMessage)
					.font(.caption)
					.foregroundStyle(Color("Error"))
			}
			
			if let cocktails = viewModel.results {
				CocktailGrid(items: cocktails, title: "", onCardPress: {})
			}
		}
		
		
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	SearchScreen(router: router)
}
