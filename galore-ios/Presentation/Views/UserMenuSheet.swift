//
//  UserMenuSheet.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//

import SwiftUI

struct UserMenuSheet: View {
	
	@StateObject  var router: Router<Routes>
	
	
	init(router: Router<Routes>) {
		_router = StateObject(wrappedValue: router)
	}
	var body: some View {
		VStack {
			UserCard(
				name: .constant("Sebastijan Zindl"), email: .constant("sebastijanzindl@protonmail.com"), imageURL: .constant("https://images.unsplash.com/photo-1633957897986-70e83293f3ff?q=80&w=2163&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
			)
			
		}.presentationDetents([.medium])

	}
}

#Preview {
	@Previewable @State  var route: Routes? = nil
	let router = Router<Routes>(isPresented: Binding(projectedValue: $route))
	
	UserMenuSheet(router: router)
}
