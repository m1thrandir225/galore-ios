//
//  AppHeader.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//

import SwiftUI

struct AppHeader: View {
	var openMenu: (() -> Void)
    var body: some View {
		HStack {
			Logo()
			Spacer()
			Button {
				openMenu()
			} label: {
				Image(systemName: "person.circle")
					.resizable()
					.scaledToFit()
					.frame(width: 28, height: 28)
					.foregroundStyle(Color("MainColor"))
			}
		}
		.frame(maxWidth: .infinity)
		.padding()
    }
}

#Preview {
	AppHeader(openMenu: {})
}
