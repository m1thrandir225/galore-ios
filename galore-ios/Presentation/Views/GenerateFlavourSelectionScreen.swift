//
//  GenerateFlavourSelectionScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 1.1.25.
//
import SwiftUI
import Foundation

struct GenerateFlavourSelectionScreen : View {
	@StateObject var router: Router<TabRoutes>
	@StateObject var viewModel: GenerateFlavourSelectionViewModel = GenerateFlavourSelectionViewModel()
	

	let columns = [GridItem(.fixed(190)), GridItem(.fixed(190))]
	
	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			BackButton {
				router.dismiss()
			}
			Spacer()
			Text("Please select up to 3 flavours ")
				.font(.system(size: 32, weight: .semibold))
				.multilineTextAlignment(.center)
				.frame(width: 400)
			if let flavours = viewModel.flavours {
				LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
					ForEach(flavours, id: \.id) { flavour in
						let shouldBeDisabled = !viewModel.isFlavourSelected(flavour.id) && viewModel.selectedFlavours.count >= 3
						Button {
							let generator = UIImpactFeedbackGenerator(style: .heavy)
							viewModel.addOrRemoveFlavourToSelected(flavour.id)
							generator.impactOccurred()
							
						} label: {
							HStack {
								Image(systemName: viewModel.isFlavourSelected(flavour.id) ? "minus" : "plus" )
								Text(flavour.name)
									.font(.system(size: 18, weight: .semibold))
							}
							.foregroundStyle(viewModel.isFlavourSelected(flavour.id) ? Color("OnMain") : Color("MainColor"))
							
							.frame(minWidth: 0, maxWidth: .infinity)
							
							.padding()
							.background(
								viewModel.isFlavourSelected(flavour.id) ? Color("MainColor") : shouldBeDisabled ? Color("MainContainer") : Color("Background")
							)
							.clipShape(RoundedRectangle(cornerRadius: 16))
							.overlay(
								RoundedRectangle(cornerRadius: 16)
									.stroke(viewModel.isFlavourSelected(flavour.id) ? Color("Secondary") : Color("MainColor").opacity(0.5), lineWidth: 2)
							)
							.transition(.scale.combined(with: .opacity))
							.animation(.spring(duration: 0.3, bounce: 0.5, blendDuration: 0), value: viewModel.isFlavourSelected(flavour.id))
						}
						.disabled(viewModel.isLoading || shouldBeDisabled)
					}
					
				}
			}
				Button {
				
			} label: {
				Text("Continue")
					.frame(maxWidth: .infinity)
			}
			.buttonStyle(
				MainButtonStyle(isDisabled: viewModel.isLoading || viewModel.selectedFlavours.count == 0)
			)
			Spacer()
			
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
	
	let flavours = [
		Flavour(id: "1", name: "Sweet", createdAt: "2024-12-01T10:00:00Z"),
		Flavour(id: "2", name: "Sour", createdAt: "2024-12-02T12:30:00Z"),
		Flavour(id: "3", name: "Bitter", createdAt: "2024-12-03T15:45:00Z"),
		Flavour(id: "4", name: "Herbaceous", createdAt: "2024-12-04T18:20:00Z"),
		Flavour(id: "5", name: "Smokey", createdAt: "2024-12-05T21:10:00Z"),
		Flavour(id: "6", name: "Savoury", createdAt: "2024-12-05T21:10:00Z"),
		Flavour(id: "7", name: "Spicy", createdAt: "2024-12-05T21:10:00Z"),
		Flavour(id: "8", name: "Fruity", createdAt: "2024-12-05T21:10:00Z")
	]
	GenerateFlavourSelectionScreen(router: router)
}
