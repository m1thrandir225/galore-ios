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
class ProfilePictureModel : ObservableObject {
	enum ImageState : Equatable {
		case empty
		case loading(Progress)
		case success(Image)
		case failure(Error)
		
		static func == (lhs: ImageState, rhs: ImageState) -> Bool {
				   switch (lhs, rhs) {
				   case (.empty, .empty):
					   return true
				   case (.loading(let lhsProgress), .loading(let rhsProgress)):
					   return lhsProgress.fractionCompleted == rhsProgress.fractionCompleted
				   case (.success, .success):
					   return true // Compare more deeply if needed, depending on use case
				   case (.failure(let lhsError), .failure(let rhsError)):
					   return lhsError.localizedDescription == rhsError.localizedDescription
				   default:
					   return false
				   }
			   }
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
	
	private(set) var avatarFileURL: URL? = nil
	
	public struct ProfileImage: Transferable {
		let image: Image
		let url: URL
		
		static var transferRepresentation: some TransferRepresentation {
				  FileRepresentation(importedContentType: .image) { file in
					  // Here, we directly use the file URL from `file`
					  let fileURL = file.file.standardizedFileURL
					  #if canImport(AppKit)
					  guard let nsImage = NSImage(contentsOf: fileURL) else {
						  throw TransferError.importFailed
					  }
					  let image = Image(nsImage: nsImage)
					  return ProfileImage(image: image, url: fileURL)
					  #elseif canImport(UIKit)
					  guard let uiImage = UIImage(contentsOfFile: fileURL.path) else {
						  throw TransferError.importFailed
					  }
					  let image = Image(uiImage: uiImage)
					  return ProfileImage(image: image, url: fileURL)
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
					self.avatarFileURL = profileImage.url // Set the URL
					
				case .success(nil):
					self.imageState = .empty
					self.avatarFileURL = nil
				case .failure(let error):
					self.imageState = .failure(error)
					self.avatarFileURL = nil
				}
			}
		}
	}

}





