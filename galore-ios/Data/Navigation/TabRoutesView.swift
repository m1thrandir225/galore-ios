//
//  TabRoutesView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI

struct TabRoutesView : View {
	@State var isPresented: Bool = false
	var body: some View {
		RoutingView(TabRoutes.self) { router in
			VStack {
				AppHeader(openMenu: {
					isPresented = true
				})
				TabView {
					Tab("Home", systemImage: "house") {
						HomeScreen(router: router)
					}
					Tab("Search", systemImage: "magnifyingglass") {
						SearchScreen(router: router)
					}
					Tab("Generate", systemImage: "wand.and.sparkles") {
						GenerateScreen(router: router)
					}
					Tab("Library", systemImage: "books.vertical") {
						LibraryScreen(router: router)
					}
				}.accentColor(Color("MainColor"))
			}.sheet(isPresented: $isPresented) {
				UserMenuSheet(router: router, dismissSheet: {
					isPresented=false
				})
			}
		}

	}
}