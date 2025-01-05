//
//  ViewStatusView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
import SwiftUI
struct GenerateStatusView : View {
	@Binding var isLoading: Bool
	@Binding var requests: [GenerateCocktailRequest]?
	
	var body: some View {
		VStack(alignment: .leading) {
			if isLoading {
				ProgressView()
					.frame(maxWidth: .infinity, maxHeight: .infinity)
				
			} else {
				ScrollView (.vertical, showsIndicators: false){
					if let requests = requests {
						ForEach(requests.indices, id: \.self) { index in
							RequestCard(request: requests[index], indexInList: index+1)
						}
					}
				}
				.animation(.smooth, value: requests)
				.frame(maxHeight: 550)
				
			}
		}
		
	}
}

#Preview {
	@Previewable @State var isLoading = false
	@Previewable @State var dummyData: [GenerateCocktailRequest]? = [
		GenerateCocktailRequest(
			id: "1",
			userId: "user_101",
			prompt: "Create a cocktail with pineapple and rum.",
			status: "generating_images",
			errorMessage: nil,
			updatedAt: "2025-01-01T12:00:00Z",
			createdAt: "2025-01-01T11:00:00Z"
		),
		GenerateCocktailRequest(
			id: "2",
			userId: "user_102",
			prompt: "Suggest a cocktail for a party of 5.",
			status: "error",
			errorMessage: "Invalid ingredients provided.",
			updatedAt: "2025-01-01T12:15:00Z",
			createdAt: "2025-01-01T11:15:00Z"
		),
		GenerateCocktailRequest(
			id: "3",
			userId: "user_103",
			prompt: "Make a mocktail with mango and mint.",
			status: "generating_cocktail",
			errorMessage: nil,
			updatedAt: "2025-01-01T12:30:00Z",
			createdAt: "2025-01-01T12:00:00Z"
		),
		GenerateCocktailRequest(
			id: "4",
			userId: "user_104",
			prompt: "Create a cocktail for someone who likes gin.",
			status: "generating_cocktail",
			errorMessage: nil,
			updatedAt: "2025-01-01T13:00:00Z",
			createdAt: "2025-01-01T12:45:00Z"
		),
		GenerateCocktailRequest(
			id: "5",
			userId: "user_105",
			prompt: "Suggest a festive cocktail for Christmas.",
			status: "generating_cocktail",
			errorMessage: "Service temporarily unavailable.",
			updatedAt: "2025-01-01T13:30:00Z",
			createdAt: "2025-01-01T13:00:00Z"
		)
	]
	
	
	GenerateStatusView(isLoading: $isLoading, requests: $dummyData)
}
