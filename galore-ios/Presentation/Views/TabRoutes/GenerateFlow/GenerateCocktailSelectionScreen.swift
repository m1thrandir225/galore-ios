//
//  GenerateCocktailSelectionScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.1.25.
//

import SwiftUI

struct GenerateCocktailSelectionScreen: View {
	@StateObject var router: Router<TabRoutes>
	@StateObject var viewModel: GenerateCocktailSelectionViewModel = GenerateCocktailSelectionViewModel()
	
	private enum Field: Int, Hashable, CaseIterable {
		case search
	}
	
	@State var searchText: String = ""
	@FocusState private var focus: Field?
	
	
	let columns = [
		GridItem(.flexible(minimum: 150), spacing: 16),
		GridItem(.flexible(minimum: 150), spacing: 16)
	]
	
	let selectedFlavours: [String]
	
    var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			BackButton {
				router.dismiss()
			}
			Text("Please select up to 3 cocktails.")
				.font(.system(size: 28, weight: .semibold))
				.multilineTextAlignment(.center)
				.frame(maxWidth: .infinity)
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
						.padding(.all, 14)
						.overlay(
							RoundedRectangle(cornerRadius: 12)
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
				

				
			}.background(Color("Background"))
			
			ScrollView(.vertical, showsIndicators: false) {
				LazyVGrid(
					columns: columns,
					alignment: .center,
					spacing: 16
				){
					ForEach(viewModel.cocktails, id: \.id) { item in
						let shouldBeDisabled =
						!viewModel.isCocktailSelected(item.name) && viewModel.selectedCocktails.count >= 3
						ClickableCocktailCard (
							id: item.id,
							title: item.name,
							isSelected: viewModel.isCocktailSelected(item.name),
							isDisabled: shouldBeDisabled,
							imageURL: item.imageUrl.toUrl!,
							minWidth: 150,
							maxWidth: .infinity
						) { name in
							viewModel.addOrRemoveToSelected(name: name)
						}
						.transition(.opacity.combined(with: .blurReplace))
					}
				}
				.padding(.horizontal, 16)
				.padding(.vertical, 16)
			}
			
			Button {
				Task {
					 await viewModel.createGenerateRequest(selectedFlavours: selectedFlavours) {
						 router.popUntil(.generate)
					}
				}
				
			} label: {
				Text("Generate Cocktail")
					.frame(maxWidth: .infinity)
			}
			.disabled(viewModel.isLoading || viewModel.selectedCocktails.count == 0)
			.buttonStyle(
				MainButtonStyle(
					isDisabled: viewModel.isLoading || viewModel.selectedCocktails.count == 0
				)
			)
			
		}
		.navigationBarBackButtonHidden(true)
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.padding(24)
		.background(Color("Background"))
		.task {
			await viewModel.loadData()
		}
		
    }
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	let selectedFlavours: [String] = [
		"Sweet",
		"Bitter"
	]
	GenerateCocktailSelectionScreen(router: router, selectedFlavours: selectedFlavours)
}
