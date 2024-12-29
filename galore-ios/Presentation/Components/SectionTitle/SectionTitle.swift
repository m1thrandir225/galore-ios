//
//  SectionTitle.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//

import SwiftUI

struct SectionTitle: View {
	let text: String
	let fontSize: CGFloat
	
	init(text: String, fontSize: CGFloat = 42) {
		self.text = text
		self.fontSize = fontSize
	}
    var body: some View {
		HStack(alignment: .center ) {
			Text(text)
				.font(.system(size: fontSize, weight: .bold))
				.foregroundStyle(Color("MainColor"))
				.multilineTextAlignment(.leading)
			Spacer()
		}.frame(maxWidth: .infinity)
    }
}

#Preview {
	SectionTitle(text: "Section Title")
}
