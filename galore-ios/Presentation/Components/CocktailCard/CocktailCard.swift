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
	
	@State var opacity = 1.0
	
	let width: CGFloat
	var onCardPress: () -> Void
	

	
	init(title: String, isLiked: Bool, imageURL: URL, width: CGFloat = 300.0, onCardPress: @escaping () -> Void) {
		self.title = title
		self.isLiked = isLiked
		self.imageURL = imageURL
		self.width = width
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
				
			}.padding(.all, 12)
		}
		.frame(width: width)
		.background(Color("MainColor").opacity(0.1))
		.clipShape(RoundedRectangle(cornerRadius: 12))
		.overlay(
			RoundedRectangle(cornerRadius: 12)
				.stroke(Color("Outline"), lineWidth: 1)
		)
		.shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
		.opacity(opacity)
		.onTapGesture {
			Task {
				withAnimation {
					opacity = 0.5
				}
				onCardPress()
				
				try? await Task.sleep(nanoseconds: 500_000_000)
				
				withAnimation {
					opacity = 1.0
				}
			}
			
			
			
		}
	}
}

#Preview {
	CocktailCard(
		title: "Example Title", isLiked: true, imageURL: "https://images.unsplash.com/photo-1726853546098-380e29da9e31?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D".toUrl!,
		width: 250
	) {
		print("hello world")
	}
}


