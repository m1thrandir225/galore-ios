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
	@ObservedObject var viewModel: ProfilePictureModel
	@State private var showPermissionAlert: Bool = false
	
	private func checkLibraryPermissions() {
		let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
			
			switch status {
			case .notDetermined:
				PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
					if newStatus == .authorized || newStatus == .limited {
						// Permission granted, do nothing as PhotosPicker will work
					} else {
						showPermissionAlert = true
					}
				}
			case .restricted, .denied:
				showPermissionAlert = true
			case .authorized, .limited:
				// Permission already granted, do nothing
				break
			@unknown default:
				fatalError("Unknown authorization status")
			}
	}
	
	private func openSettings() {
		 if let url = URL(string: UIApplication.openSettingsURLString) {
			 UIApplication.shared.open(url)
		 }
	 }
	
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
				.onTapGesture {
					checkLibraryPermissions()
				}
			}
			.alert("Photo Library Access Required", isPresented: $showPermissionAlert) {
							Button("Open Settings", action: openSettings)
							Button("Cancel", role: .cancel, action: {})
						} message: {
							Text("Please grant photo library access in Settings to select or edit your profile picture.")
						}
	}
}
