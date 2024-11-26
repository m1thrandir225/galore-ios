//
//  GenerateScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI

struct GenerateScreen :  View {
	@StateObject  var router: Router<TabRoutes>
	
	init(router: Router<TabRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
	
	var body: some View {
		ScrollView {
			Text("Generate Screen")
		}
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	GenerateScreen(router: router)
}
