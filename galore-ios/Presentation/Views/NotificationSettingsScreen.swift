//
//  NotificationSettingsScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//

import SwiftUI

struct NotificationSettingsScreen: View {
	@StateObject var router: Router<TabRoutes>
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	NotificationSettingsScreen(router: router)
}
