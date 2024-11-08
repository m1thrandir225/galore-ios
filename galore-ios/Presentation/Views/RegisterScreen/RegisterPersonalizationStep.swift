//
//  RegisterPersonalizationStep.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 7.11.24.
//

import SwiftUI

struct RegisterPersonalizationStep: View {
	@Binding var birthday: Date?
	@Binding var networkFile: NetworkFile?
	
	
	@StateObject var imageModel = ProfilePictureModel()
    var body: some View {
		VStack(alignment: .center, spacing: 24) {
			EditableCircularProfileImage(viewModel: imageModel)
				.onChange(of: imageModel.imageState) { oldState, newState in
					switch newState {
								case .success(_):
						if let file = imageModel.networkFile {
							networkFile = file // Update Binding when image successfully loaded
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
	RegisterPersonalizationStep(birthday: Binding<Date?>(get: { nil }, set: { _ in }), networkFile: Binding<NetworkFile?>(get: { nil }, set: { _ in }))
}
