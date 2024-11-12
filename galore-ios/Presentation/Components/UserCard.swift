//
//  UserCard.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//
import SwiftUI
import NukeUI

struct UserCard: View {
	@Binding var name: String
	@Binding var email: String
	@Binding var imageURL: String
	
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
		name: .constant("Sebastijan Zindl"),
		email: .constant("sebastijanzindl@gmail.com"),
		imageURL: .constant("https://picsum.photos/64/64")
	)
}
