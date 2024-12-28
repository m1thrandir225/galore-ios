//
//  ErrorMessage.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//

import SwiftUI

struct ErrorMessage: View {
	let text: String
	var body: some View {
		Text("Error: \(text)")
			.font(.system(size: 16, weight: .semibold))
			.foregroundColor(Color("Error"))
			.transition(.slide.combined(with: .scale))
	}
}

#Preview {
	ErrorMessage(text: "Something went wrong")
}
