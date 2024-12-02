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
	
	@State private var showingHeader = true
	@State private var turningPoint = CGFloat.zero // ADDED
	let thresholdScrollDistance: CGFloat = 50 // ADDED
	
	@FocusState private var focus: Field?
	
	private enum Field: Int, Hashable, CaseIterable {
		case search
	}
	
	let columns = [GridItem(.fixed(180)), GridItem(.fixed(180))]
	
	init(router: Router<TabRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
	
	var body: some View {
		VStack {
			if showingHeader {
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
								await viewModel.searchCocktail(with: searchText)
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
					.transition(
						.asymmetric(
							insertion: .push(from: .top),
							removal: .push(from: .bottom)
						)
					)
			}
			
			
			
			if let errorMessage = viewModel.errorMessage {
				Text(errorMessage)
					.font(.caption)
					.foregroundStyle(Color("Error"))
			}
			
			if viewModel.isLoading {
				ProgressView()
			}
			
			if let cocktails = viewModel.results {
				GeometryReader { outerReader in
					let outerHeight = outerReader.size.height
					ScrollView {
						LazyVGrid(columns: columns, alignment: .center, spacing: 24) {
							ForEach(cocktails, id: \.id) { item in
								CocktailCard (
									title: item.name,
									isLiked: false,
									imageURL: item.imageUrl.toUrl!,
									width: 180,
									onCardPress: {}
								)
							}
						}.background {
							GeometryReader { proxy in
								let contentHeight = proxy.size.height
								let minY = max(
									min(0, proxy.frame(in: .named("ContentScrollView")).minY),
									outerHeight - contentHeight
								)
								Color.clear
									.onChange(of: minY) { oldVal, newVal in
										if (showingHeader && newVal > oldVal) || (!showingHeader && newVal < oldVal) {
											   turningPoint = newVal
										   }
										if (showingHeader && (turningPoint - newVal) > thresholdScrollDistance) ||
											(!showingHeader && (newVal - turningPoint) > thresholdScrollDistance) {
											showingHeader = newVal > turningPoint
										}
									}
							}
						}
					}.coordinateSpace(name: "ContentScrollView")
				}.padding(.top, 1)
			}
		}.animation(.easeInOut, value: showingHeader)
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	SearchScreen(router: router)
}
