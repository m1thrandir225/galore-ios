//
//  EditableCircularProfileImage.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//


import Foundation
import SwiftUI
import PhotosUI

struct EditableCircularProfileImage: View {
	@ObservedObject var viewModel: ProfileModel
	
	var body: some View {
		CircularProfileImage(imageState: viewModel.imageState)
			.overlay(alignment: .bottomTrailing) {
				PhotosPicker(selection: $viewModel.imageSelection,
							 matching: .images,
							 photoLibrary: .shared()) {
					Image(systemName: "pencil.circle.fill")
						.symbolRenderingMode(.multicolor)
						.font(.system(size: 30))
						.foregroundColor(.accentColor)
				}
				.buttonStyle(.borderless)
			}
	}
}
