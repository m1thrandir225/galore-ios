//
//  TabViewRoutes.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//
import SwiftUI

struct CocktailDetailsArgs : Equatable {
	static func == (lhs: CocktailDetailsArgs, rhs: CocktailDetailsArgs) -> Bool {
		return lhs.id == rhs.id
	}
	
	let id: String
	let rootSentFrom: (any Routable)?
}

struct CocktailSectionArgs : Equatable {
	let cocktails: [Cocktail]
	let title: String
}

enum TabRoutes: Routable {
	case home
	case search
	case library
	case generate
	case help
	case privacyPolicy
	case termsAndConditions
	case settingsOverview
	case updateProfile
	case changePassword
	case notificationSettings
	case cocktailDetails(CocktailDetailsArgs)
	case cocktailSection(CocktailSectionArgs)
	
	enum RouteArgs {
		case none
		case cocktailDetails(CocktailDetailsArgs)
		case cocktailSection(CocktailSectionArgs)
	}
	
	var arguments: RouteArgs {
		switch self {
		case .cocktailDetails(let args):
			return .cocktailDetails(args)
		case .cocktailSection(let args):
			return .cocktailSection(args)
		default:
			return .none
		}
	}

	
	var navigationType: NavigationType  {
		switch self {
		case
				.generate,
				.home,
				.library,
				.search,
				.settingsOverview,
				.updateProfile,
				.changePassword,
				.cocktailDetails,
				.cocktailSection,
				.notificationSettings:
					.push
		case .help, .privacyPolicy, .termsAndConditions:
				.sheet
		}
	}
	
	@ViewBuilder
	func viewToDisplay(router: Router<TabRoutes>) -> some View {
		switch self {
		case .home:
			HomeScreen(router: router)
		case .generate:
			GenerateScreen(router: router)
		case .library:
			LibraryScreen(router: router)
		case .search:
			SearchScreen(router: router)
		case .settingsOverview:
			OverviewSettingsScreen(router: router)
		case .help:
			HelpScreen(router: router)
		case .privacyPolicy:
			PrivacyPolicyScreen(router: router)
		case .termsAndConditions:
			TermsAndConditionsScreen(router: router)
		case .updateProfile:
			UpdateProfileScreen(router: router)
		case .changePassword:
			ChangePasswordScreen(router: router)
		case .notificationSettings:
			NotificationSettingsScreen(router: router)
		case .cocktailDetails(let args):
			CocktailDetailsScreen(router: router, cocktailId: args.id, rootSentFrom: args.rootSentFrom ?? nil)
		case .cocktailSection(let args):
			CocktailSectionScreen(router: router, cocktails: args.cocktails, title: args.title)
		}
	}
	
}
