//
//  CocktailCard.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 14.11.24.
//

import SwiftUI
import NukeUI

struct CocktailCard: View {
	@State var title: String
	@State var isLiked: Bool
	@State var imageURL: URL
	
	var onHeartPress: (Bool) -> Void
	
	init(title: String, isLiked: Bool, imageURL: URL, onHeartPress: @escaping (Bool) -> Void) {
		self.title = title
		self.isLiked = isLiked
		self.imageURL = imageURL
		self.onHeartPress = onHeartPress
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
					Image(systemName: "")
						.resizable()
						.scaledToFit()
						.frame(height:200)
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
					.foregroundStyle(Color("MainColor"))
				
				Spacer()
				
				HeartButton(isPressed: false) {
					print("hello World")
				}
				
			}.padding(.all, 12)
		}
		.frame(width: 300)
		.background(Color("MainColor").opacity(0.1))
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color("Outline"), lineWidth: 1)
		)
		.shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
		.padding()
		
	}
}

#Preview {
	CocktailCard(
		title: "Example Title", isLiked: true, imageURL: "https://images.unsplash.com/photo-1726853546098-380e29da9e31?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D".toUrl!	, onHeartPress: { _ in }
	)
}

