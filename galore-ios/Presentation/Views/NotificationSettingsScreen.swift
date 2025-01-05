//
//  NotificationSettingsScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//

import SwiftUI

struct NotificationSettingsScreen: View {
	@StateObject var router: Router<TabRoutes>
	@StateObject var viewModel: NotificationSettingsViewModel = NotificationSettingsViewModel()
	@State var isOn: Bool = false
	
	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			BackButton {
				router.dismiss()
			}
			SectionTitle(text: "Notifications", fontSize: 32)
			
			if let pushNotificationsEnabled = $viewModel.pushNotificationsEnabled.optionalBinding(), let emailNotificationsEnabled = $viewModel.emailNotificationsEnabled.optionalBinding() {
				Toggle(
					"Push Notifications",
					systemImage: "bell",
					isOn: pushNotificationsEnabled
				)
				.font(.system(size: 16, weight: .medium))
				.foregroundStyle(Color("Secondary"))
				.toggleStyle(SwitchToggleStyle(tint: Color("Secondary")))
				
				Toggle(
					"Email Notifications",
					systemImage: "envelope",
					isOn: emailNotificationsEnabled
				)
				.font(.system(size: 16, weight: .medium))
				.foregroundStyle(Color("Secondary"))
				.toggleStyle(SwitchToggleStyle(tint: Color("Secondary")))
				
				Button {
					Task {
						await viewModel.updateNotificationSettings() {
							router.dismiss()
						}
					}
				} label: {
					ZStack {
						if viewModel.isLoading {
							// Show loading spinner
							ProgressView()
								.progressViewStyle(CircularProgressViewStyle(tint: (Color("OnMain"))))
								.foregroundColor(Color("OnMain"))
							
							
						} else {
							// Show the button label
							Text("Update Preferences")
								.font(.system(size: 18, weight: .semibold))
						}
					}
					.frame(maxWidth: .infinity) // Keeps the button width consistent
				}
				.disabled(viewModel.isLoading)
				.buttonStyle(
					MainButtonStyle(isDisabled: viewModel.isLoading)
				)
				
				if let errorMessage = viewModel.errorMessage {
					ErrorMessage(text: errorMessage)
						.animation(.smooth, value: errorMessage)
				}
			}
			if let successMessage = viewModel.successMessage {
				Text(successMessage)
					.font(.system(size: 24, weight: .bold))
					.foregroundStyle(Color("Teritary"))
			}
			Spacer()
			Logo()
				.frame(maxWidth: .infinity)
		}
		.onAppear {
			viewModel.fetchNotificationSettings()
		}
		.padding(24)
		.background(Color("Background"))
		.navigationBarBackButtonHidden(true)
		
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	NotificationSettingsScreen(router: router)
}
