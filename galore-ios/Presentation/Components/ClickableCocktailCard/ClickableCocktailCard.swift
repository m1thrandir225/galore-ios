//
//  CocktailCard.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 14.11.24.
//

import SwiftUI
import NukeUI

struct ClickableCocktailCard: View {
	@State var title: String
	
	@State var imageURL: URL
	
	@State var opacity = 1.0

	let id: String
	let minWidth: CGFloat
	let maxWidth: CGFloat
	var onCardPress: (_: String) -> Void
	var isSelected: Bool
	var isDisabled: Bool
	
	
	init(
		id: String,
		title: String,
		isSelected: Bool,
		isDisabled: Bool,
		imageURL: URL,
		minWidth: CGFloat = 150.0,
		maxWidth: CGFloat = 200.0,
		onCardPress: @escaping (_: String) -> Void
	) {
		self.id = id
		self.title = title
		self.isSelected = isSelected
		self.isDisabled = isDisabled
		self.imageURL = imageURL
		self.minWidth = minWidth
		self.maxWidth = maxWidth
		self.onCardPress = onCardPress
	}
	
	var body: some View {
		VStack {
			LazyImage(url: imageURL) { state in
				if let image = state.image {
					image.resizable()
						.scaledToFill()
						.frame(height: 200)
						.clipShape(.rect(
							topLeadingRadius: 12,
							bottomLeadingRadius: 0,
							bottomTrailingRadius: 0,
							topTrailingRadius: 12
						))
				} else if state.isLoading {
					ProgressView()
				} else {
					Color.teritary
						.frame(height: 200)
						.clipShape(.rect(
							topLeadingRadius: 12,
							bottomLeadingRadius: 0,
							bottomTrailingRadius: 0,
							topTrailingRadius: 12
						))
					
				}
			}
			
			HStack(alignment: .center){
				Text(title)
					.font(.system(size: 16, weight: .semibold))
					.foregroundStyle(isSelected ? Color("OnMain") : isDisabled ? Color("OnSecondaryContainer") : Color("MainColor"))
				Spacer()
				
			}.padding(.all, 12)
				.frame(height: 50)
		}

		.frame(minWidth: minWidth, maxWidth: maxWidth)
		.frame(height: 250)
		.background(isSelected ? Color("MainColor").opacity(0.75) : isDisabled ? Color("Secondary").opacity(0.5) :  Color("MainContainer").opacity(0.5))
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color.outline, lineWidth: 1)
		)
		.shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
		.opacity(opacity)
		.disabled(isDisabled)
		.onTapGesture {
			Task {
				withAnimation {
					opacity = 0.5
				}
				onCardPress(title)
				
				try? await Task.sleep(nanoseconds: 500_000_000)
				
				withAnimation {
					opacity = 1.0
				}
			}
			
			
			
		}
	}
}

#Preview {
	ClickableCocktailCard(
		id: "1",
		title: "Example Title",
		isSelected: false,
		isDisabled: true,
		imageURL:"https://images.unsplash.com/photo-1726853546098-380e29da9e31?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D".toUrl!,
		minWidth: 250,
		maxWidth: 250
	) { _ in
		print("hello world")
	}
}


