//
//  CircularProfileImage.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//


import Foundation
import SwiftUI
import PhotosUI



struct CircularProfileImage: View {
	let imageState: ProfilePictureModel.ImageState
	
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
