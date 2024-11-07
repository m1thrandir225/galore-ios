//
//  RegisterPersonalizationStep.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 7.11.24.
//

import SwiftUI

struct RegisterPersonalizationStep: View {
	@Binding var birthday: Date?
	@Binding var avatarURL: URL?
	
	
	@StateObject var imageModel = ProfilePictureModel()
    var body: some View {
		VStack(alignment: .center, spacing: 24) {
			EditableCircularProfileImage(viewModel: imageModel)
				.onChange(of: imageModel.imageState) { oldState, newState in
					switch newState {
								case .success(let profileImage):
									if let profileURL = imageModel.avatarFileURL {
										avatarURL = profileURL // Update Binding when image successfully loaded
										print(avatarURL)
									}
								default:
									break // Ignore in this context.
								}
				}
			DatePickerOptional("Birthday", prompt: "Add Date", in: ...Date(), selection: $birthday)
		}
		.padding(.all, 20)
		Spacer()
    }
}

#Preview {
	RegisterPersonalizationStep(birthday: Binding<Date?>(get: { nil }, set: { _ in }), avatarURL: Binding<URL?>(get: { nil }, set: { _ in }))
}
