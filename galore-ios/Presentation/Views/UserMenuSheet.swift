//
//  UserMenuSheet.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//

import SwiftUI

struct UserMenuItem {
	let title: String
	let iconName: String
}

enum UserMenuSheetItems: CaseIterable {
	case settings
	case help
	case logout
	
	var menuItem: UserMenuItem {
		switch self {
		case .settings:
			return UserMenuItem(title: "Settings", iconName: "gear")
		case .help:
			return UserMenuItem(title: "Help", iconName: "questionmark.circle")
		case .logout:
			return UserMenuItem(title: "Logout", iconName: "rectangle.portrait.and.arrow.right")
		}
	}
}
struct UserMenuSheet: View {
	var dismissSheet: () -> Void
	@StateObject  var router: Router<Routes>
	@StateObject var viewModel: UserMenuSheetViewModel = UserMenuSheetViewModel()
	
	init(router: Router<Routes>, dismissSheet: @escaping () -> Void ) {
		_router = StateObject(wrappedValue: router)
		self.dismissSheet = dismissSheet
	}
	var body: some View {
		VStack(alignment: .center, spacing: 24) {
			if let user = viewModel.user {
				UserCard(
					name: user.name,
					email: user.email,
					imageURL: user.avatar != nil ? "http://localhost:8080/\(user.avatar!)" : ""
				)
			}
			VStack(alignment: .leading, spacing: 12) {
				ForEach(UserMenuSheetItems.allCases, id: \.self) { item in
					UserMenuSheetNavigationItem(iconName: item.menuItem.iconName, text: item.menuItem.title) {
						switch item {
						case .logout:
							Task {
									await viewModel.logout()
							}
						case .help:
							Task {
								dismissSheet()
								try await Task.sleep(nanoseconds: 100)
								router.routeTo(.help)
							}
							
						case .settings:
							Task {
								dismissSheet()
								try await Task.sleep(nanoseconds: 100)
								router.routeTo(.settings)
							}
							
						}
					}
				}
			}.padding()
			
	
			
		}.presentationDetents([.medium])
			.presentationDragIndicator(.visible)
			.onAppear {
				viewModel.getUser()
			}

	}
}

#Preview {
	@Previewable @State  var route: Routes? = nil
	let router = Router<Routes>(isPresented: Binding(projectedValue: $route))
	
	UserMenuSheet(router: router, dismissSheet: {})
}
