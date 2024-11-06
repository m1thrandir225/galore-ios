//
//  LoadingScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
		VStack(alignment: .center) {
			ProgressView(label: {
				Text("Prepearing concoctions...")
			})
		}.background(Color("Backgrdoun"))
    }
}

#Preview {
    LoadingScreen()
}
