import Foundation
import SwiftUI
import PhotosUI

@MainActor
class ProfilePictureModel: ObservableObject {
	enum ImageState: Equatable {
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
				return true
			case (.failure(let lhsError), .failure(let rhsError)):
				return lhsError.localizedDescription == rhsError.localizedDescription
			default:
				return false
			}
		}
	}
	
	enum TransferError: Error {
		case importFailed
		case networkLoadFailed
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
	
	private(set) var networkFile: NetworkFile? = nil
	
	// Add initializer with optional URL
	init(networkImageURL: URL? = nil) {
		if let url = networkImageURL {
			loadNetworkImage(from: url)
		}
	}
	
	// Add function to load network image
	private func loadNetworkImage(from url: URL) {
		imageState = .loading(Progress(totalUnitCount: 1))
		
		Task {
			do {
				let (data, _) = try await URLSession.shared.data(from: url)
				
				#if canImport(AppKit)
				guard let nsImage = NSImage(data: data) else {
					throw TransferError.networkLoadFailed
				}
				let image = Image(nsImage: nsImage)
				#elseif canImport(UIKit)
				guard let uiImage = UIImage(data: data) else {
					throw TransferError.networkLoadFailed
				}
				let image = Image(uiImage: uiImage)
				#else
				throw TransferError.networkLoadFailed
				#endif
				
				self.imageState = .success(image)
				self.networkFile = NetworkFile(url: url, data: data)
			} catch {
				self.imageState = .failure(error)
				self.networkFile = nil
			}
		}
	}
	
	public struct ProfileImage: Transferable {
		let image: Image
		let url: URL
		
		func imageData() -> Data? {
			return try? Data(contentsOf: url)
		}
		
		static var transferRepresentation: some TransferRepresentation {
			FileRepresentation(importedContentType: .image) { file in
				let fileURL = file.file
				#if canImport(AppKit)
				guard let nsImage = NSImage(contentsOf: fileURL) else {
					throw TransferError.importFailed
				}
				let image = Image(nsImage: nsImage)
				return ProfileImage(image: image, url: fileURL)
				#elseif canImport(UIKit)
				guard let uiImage = UIImage(contentsOfFile: fileURL.path()) else {
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
					self.networkFile = NetworkFile(url: profileImage.url, data: profileImage.imageData()!)
				case .success(nil):
					self.imageState = .empty
					self.networkFile = nil
				case .failure(let error):
					self.imageState = .failure(error)
					self.networkFile = nil
				}
			}
		}
	}
}
