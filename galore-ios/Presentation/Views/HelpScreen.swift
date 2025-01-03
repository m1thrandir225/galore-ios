//
//  HelpScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 14.11.24.
//

import SwiftUI

struct HelpScreen: View {
	@StateObject  var router: Router<TabRoutes>
	
	init(router: Router<TabRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	HelpScreen(router: router)
}
