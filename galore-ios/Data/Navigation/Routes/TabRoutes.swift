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


struct GenerateSelectCocktailArgs : Equatable {
	let selectedFlavours: [String]
}

struct GeneratedCocktailDetailsArgs: Equatable {
	let cocktailId: String
}

struct GeneratedCocktailSectionArgs : Equatable {
	let cocktails: [GeneratedCocktail]
	let title: String
}

enum TabRoutes: Routable {
	case home
	case search
	case library
	case generate
	case generateSelectFlavours
	case generateSelectCocktails(GenerateSelectCocktailArgs)
	case help
	case privacyPolicy
	case termsAndConditions
	case settingsOverview
	case updateProfile
	case changePassword
	case notificationSettings
	case cocktailDetails(CocktailDetailsArgs)
	case generatedCocktailDetails(GeneratedCocktailDetailsArgs)
	case cocktailSection(CocktailSectionArgs)
	case generatedCocktailSection(GeneratedCocktailSectionArgs)
	
	enum RouteArgs {
		case none
		case cocktailDetails(CocktailDetailsArgs)
		case cocktailSection(CocktailSectionArgs)
		case generateSelectCocktails(GenerateSelectCocktailArgs)
		case generatedCocktailDetails(GeneratedCocktailDetailsArgs)
		case generatedCocktailSection(GeneratedCocktailSectionArgs)
	}
	
	var arguments: RouteArgs {
		switch self {
		case .cocktailDetails(let args):
			return .cocktailDetails(args)
		case .cocktailSection(let args):
			return .cocktailSection(args)
		case .generateSelectCocktails(let args):
			return .generateSelectCocktails(args)
		case .generatedCocktailDetails(let args):
			return .generatedCocktailDetails(args)
		case .generatedCocktailSection(let args):
			return .generatedCocktailSection(args)
		default:
			return .none
		}
	}

	
	var navigationType: NavigationType  {
		switch self {
		case
				.generate,
				.generateSelectFlavours,
				.generateSelectCocktails,
				.home,
				.library,
				.search,
				.settingsOverview,
				.updateProfile,
				.changePassword,
				.cocktailDetails,
				.generatedCocktailDetails,
				.cocktailSection,
				.generatedCocktailSection,
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
		case .generateSelectFlavours:
			GenerateFlavourSelectionScreen(router: router)
		case .generateSelectCocktails(let args):
			GenerateCocktailSelectionScreen(router: router, selectedFlavours: args.selectedFlavours)
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
		case .generatedCocktailDetails(let args):
			GeneratedCocktailDetailsScreen(router: router, cocktailId: args.cocktailId)
		case .cocktailSection(let args):
			CocktailSectionScreen(router: router, cocktails: args.cocktails, title: args.title)
		case .generatedCocktailSection(let args):
			GeneratedCocktailSectionScreen(router: router, cocktails: args.cocktails, title: args.title)
		}
	}
	
}
