//
//  SectionTitle.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//

import SwiftUI

struct SectionTitle: View {
	let text: String
    var body: some View {
		HStack(alignment: .center ) {
			Text(text)
				.font(.system(size: 42, weight: .bold))
				.foregroundStyle(Color("MainColor"))
				.multilineTextAlignment(.leading)
			Spacer()
		}.frame(maxWidth: .infinity)
    }
}

#Preview {
	SectionTitle(text: "Section Title")
}
