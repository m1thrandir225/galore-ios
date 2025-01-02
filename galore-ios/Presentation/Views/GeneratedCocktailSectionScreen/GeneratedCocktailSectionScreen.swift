//
//  GeneratedCocktailSectionScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//

import SwiftUI

struct GeneratedCocktailSectionScreen: View {
	@StateObject var router: Router<TabRoutes>
	
	@State var cocktails: [GeneratedCocktail]
	@State var title: String
	@State var titleVisible: Bool = true
	
	var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			HStack {
				BackButton {
					router.dismiss()
				}
				Text(title)
					.font(.system(size: 24, weight: .semibold))
					.foregroundStyle(Color("OnBackground"))
					.padding(24)
					.opacity(titleVisible ? 0 : 1)
					.animation(.easeInOut, value: titleVisible)
				Spacer()
			}
			.padding(.leading, 24)
			ScrollView(.vertical, showsIndicators: false) {
				VStack (alignment: .leading) {
					TitleVisibilityCheckerView(title: title, titleVisible: $titleVisible)
					GeneratedCocktailGrid(items: $cocktails)  { id in
						router.routeTo(.cocktailDetails(CocktailDetailsArgs(id: id,rootSentFrom: nil)))
					}
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

	GeneratedCocktailSectionScreen(router: router, cocktails: [], title: "Generated Cocktails")
}
