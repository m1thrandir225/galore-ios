//
//  ContentView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 24.10.24.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var router = Router()
	
    var body: some View {
		NavigationStack(root: $router.path) {
			WelcomeScreen()
		}
    }
}

#Preview {
    ContentView()
}
