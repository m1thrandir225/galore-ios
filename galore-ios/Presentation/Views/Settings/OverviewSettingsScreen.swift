//
//  SettingsScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 14.11.24.
//

import SwiftUI

struct OverviewSettingsScreen: View {
	@StateObject  var router: Router<TabRoutes>
	
	init(router: Router<TabRoutes>) {
		_router = StateObject(wrappedValue: router)
	}
	let columns = [GridItem(.fixed(150)), GridItem(.fixed(150))]
	
	
	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			BackButton {
				router.dismiss()
			}
			SectionTitle(text: "Settings")
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .leading, spacing: 24) {
					VStack(alignment: .leading, spacing: 24) {
						OverviewSettingsButton(
							title: "Account Settings",
							icon: "gearshape",
							action: {
								router.routeTo(.updateProfile)
							},
							hasIcon: true
						)
						OverviewSettingsButton(
							title: "Password & Security",
							icon: "key",
							action: {
								router.routeTo(.changePassword)
							},
							hasIcon: true
						)
						OverviewSettingsButton(
							title: "Notifications",
							icon: "bell",
							action: {
								router.routeTo(.notificationSettings)
							},
							hasIcon: true
						)
					}
					.padding()
					.background(Color("MainContainer").opacity(0.5))
					.clipShape(RoundedRectangle(cornerRadius: 16))
			
					VStack(alignment: .leading, spacing: 24) {
						OverviewSettingsButton(
							title: "Terms & Conditions",
							icon: "",
							action: {
								router.routeTo(.termsAndConditions)
							},
							hasIcon: false
						)
						OverviewSettingsButton(
							title: "Privacy Policy",
							icon: "",
							action: {
								router.routeTo(.privacyPolicy)
							},
							hasIcon: false
						)
					}
					.padding()
					.background(Color("MainContainer").opacity(0.5))
					.clipShape(RoundedRectangle(cornerRadius: 16))
			
				}
			}

			Spacer()
			VStack(alignment: .center, spacing: 12) {
				Logo()
				if let version = Bundle.main.releaseVersionNumber {
					Text("Version: \(version)")
						.font(.footnote)
						.foregroundStyle(Color("Outline"))
				}
			}
			.frame(maxWidth: .infinity)
		}
		.padding(.horizontal, 24)
		.background(Color("Background"))
		.navigationBarBackButtonHidden()
		
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	
	OverviewSettingsScreen(router: router)
}
