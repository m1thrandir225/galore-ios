//
//  CircularProfileImage.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//


import Foundation
import SwiftUI
import PhotosUI

struct ProfileImage: View {
	let imageState: ProfileModel.ImageState
	
	var body: some View {
		switch imageState {
		case .success(let image):
			image.resizable()
		case .loading:
			ProgressView()
		case .empty:
			Image(systemName: "person.fill")
				.font(.system(size: 40))
				.foregroundColor(.white)
		case .failure:
			Image(systemName: "exclamationmark.triangle.fill")
				.font(.system(size: 40))
				.foregroundColor(.white)
		}
	}
}

struct CircularProfileImage: View {
	let imageState: ProfileModel.ImageState
	
	var body: some View {
		ProfileImage(imageState: imageState)
			.scaledToFill()
			.clipShape(Circle())
			.frame(width: 100, height: 100)
			.background {
				Circle().fill(
					LinearGradient(
						colors: [Color("MainColor"), Color("MainColor")],
						startPoint: .top,
						endPoint: .bottom
					)
				)
			}
	}
}
