//
//  ProfilePicturePicker.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import Foundation
import SwiftUI
import PhotosUI


@MainActor
class ProfileModel : ObservableObject {
	enum ImageState {
		case empty
		case loading(Progress)
		case success(Image)
		case failure(Error)
	}


	enum TransferError: Error {
		case importFailed
	}
	@Published private(set) var imageState: ImageState = .empty
	@Published var imageSelection: PhotosPickerItem? = nil {
		didSet {
			if let imageSelection {
				let progress = loadTransferable(from: imageSelection)
				imageState = .loading(progress)
			} else {
				imageState = .empty
			}
		}
	}
	
	public struct ProfileImage: Transferable {
		let image: Image
		
		static var transferRepresentation: some TransferRepresentation {
			DataRepresentation(importedContentType: .image) { data in
			#if canImport(AppKit)
				guard let nsImage = NSImage(data: data) else {
					throw TransferError.importFailed
				}
				let image = Image(nsImage: nsImage)
				return ProfileImage(image: image)
			#elseif canImport(UIKit)
				guard let uiImage = UIImage(data: data) else {
					throw TransferError.importFailed
				}
				let image = Image(uiImage: uiImage)
				return ProfileImage(image: image)
			#else
				throw TransferError.importFailed
			#endif
			}
		}
	}
	

	
	private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
		return imageSelection.loadTransferable(type: ProfileImage.self) { result in
			DispatchQueue.main.async {
				guard imageSelection == self.imageSelection else {
					print("Failed to get the selected item.")
					return
				}
				switch result {
				case .success(let profileImage?):
					self.imageState = .success(profileImage.image)
				case .success(nil):
					self.imageState = .empty
				case .failure(let error):
					self.imageState = .failure(error)
				}
			}
		}
	}

}





