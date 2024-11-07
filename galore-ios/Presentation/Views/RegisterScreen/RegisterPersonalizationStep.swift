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
	
	@StateObject var imageModel = ProfileModel()
    var body: some View {
		VStack(alignment: .center, spacing: 24) {
			EditableCircularProfileImage(viewModel: imageModel)
			DatePickerOptional("Birthday", prompt: "Add Date", in: ...Date(), selection: $birthday)
		}
		.padding(.all, 20)
		Spacer()
    }
}

#Preview {
	RegisterPersonalizationStep(birthday: Binding<Date?>(get: { nil }, set: { _ in }), avatarURL: Binding<URL?>(get: { nil }, set: { _ in }))
}
