//
//  UserCard.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//
import SwiftUI
import NukeUI

struct UserCard: View {
	@State var name: String
	@State var email: String
	@State var imageURL: String
	
	var body: some View {
		HStack(alignment: .center, spacing: 8) {
			LazyImage(url: URL(string: imageURL)) { state in
				if let image = state.image {
					image.resizable()
						.scaledToFill()
						.frame(width: 64, height: 64)
						.clipShape(Circle())
					
				} else if state.isLoading {
						ProgressView()
				} else {
					Image(systemName: "person.crop.circle.fill")
						.resizable()
						.scaledToFit()
						.frame(width: 64, height: 64)
				}
			}
			VStack (alignment: .leading, spacing: 8) {
				Text(name)
					.font(.headline)
					.foregroundStyle(Color("OnBackground"))
				Text(email)
					.font(.subheadline)
					.foregroundStyle(Color("OnBackground"))
					
			}
		}
	}
}


#Preview {
	UserCard(
		name: ("Sebastijan Zindl"),
		email: ("sebastijanzindl@gmail.com"),
		imageURL: ("https://picsum.photos/64/64")
	)
}
