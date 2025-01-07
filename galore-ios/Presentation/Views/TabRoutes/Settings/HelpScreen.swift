//
//  HelpScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 14.11.24.
//

import SwiftUI

struct HelpScreen: View {
	@StateObject  var router: Router<TabRoutes>
	@State var titleVisible: Bool = true
	
	let paragraphs: [String: String] = [
		"Browse Cocktails":"Discover a wide range of cocktails with detailed recipes and ingredients.\nUse the search bar or filters to find your perfect drink by flavor, alcohol type, or occasion.",
		"Extra Features":"Save your favorite cocktails for easy access later.\nShare your creations with friends or on social media.",
		"Generate Your Own Cocktail":"Choose Your Flavors: Select up to 3 flavors that match your preferences (e.g., fruity, spicy, sweet).\nPick Reference Cocktails: Select up to 3 cocktails as inspiration. Our algorithm combines their best traits to craft something new and exciting!\nTap Generate Cocktail and watch the magic happen!"
	]
	
	
	init(router: Router<TabRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Text("Help")
					.font(.system(size: 24, weight: .semibold))
					.foregroundStyle(Color("OnBackground"))
					.padding(24)
					.opacity(titleVisible ? 0 : 1)
					.animation(.easeInOut, value: titleVisible)
				Spacer()
			}
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .leading, spacing: 8) {
					TitleVisibilityCheckerView(title: "Help", titleVisible: $titleVisible)
					ForEach(paragraphs.sorted(by: <), id: \.key) { key, value in
						Text(key)
							.font(.system(size: 22, weight: .semibold))
							.foregroundStyle(Color("OnBackground"))
						Text(value)
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
	HelpScreen(router: router)
}
