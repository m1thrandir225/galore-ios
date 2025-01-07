//
//  PrivacyPolicyScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//

import SwiftUI

struct PrivacyPolicyScreen: View {
	@StateObject var router: Router<TabRoutes>
	@State var titleVisible: Bool = true
	
	let paragraphs: [String] = [
		"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
		"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
		"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
		"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
	]
	
	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Privacy Policy")
					.font(.system(size: 24, weight: .semibold))
					.foregroundStyle(Color("OnBackground"))
					.padding(24)
					.opacity(titleVisible ? 0 : 1)
					.animation(.easeInOut, value: titleVisible)
				Spacer()
			}
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .leading, spacing: 24) {
					TitleVisibilityCheckerView(title: "Privacy Policy", titleVisible: $titleVisible)
					ForEach(paragraphs, id: \.self) { item in
						Text(item)
							.font(.system(size: 16, weight: .regular))
							.foregroundStyle(Color("OnBackground"))
					}.padding(.horizontal, 24)
				}
				
			}
		}
		.background(Color("Background"))
		.navigationBarBackButtonHidden(true)
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	PrivacyPolicyScreen(router: router)
}
