//
//  EnablePushNotificationsScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//
import SwiftUI
import Lottie

struct EnablePushNotificationsScreen : View {
	@StateObject var router: Router<OnboardingRoutes>
	@StateObject var viewModel: EnablePushNotificationsViewModel = EnablePushNotificationsViewModel()
	
	var body: some View {
		VStack (spacing: 24) {
			LottieView(animation: .named("notificationsLottie"))
				.playing(loopMode: .loop)
				.scaledToFill()
				.frame(height: 200)
			VStack (spacing: 12) {
				Text("Enable Push Notifications")
					.font(.system(size: 24, weight: .bold))
					.foregroundStyle(Color("MainColor"))
				
				Text("Get notified for new and upcomming concoctions.")
					.font(.system(size: 16, weight: .regular))
					.foregroundStyle(Color("OnBackground"))
					.frame(width: 200)
			}

			VStack (spacing: 32) {
				Button {
					Task {
						try await viewModel.enablePushNotifications {
							router.routeTo(.setupFlavours)
						}
					}
				} label: {
					Text("Notify me")
						.font(.system(size: 18, weight: .semibold))
						.padding()
						.foregroundStyle(Color("OnMain"))
						.background(Color("MainColor"))
						.clipShape(RoundedRectangle(cornerRadius: 16))
				}.disabled(viewModel.isLoading)
				
				Button {
					Task {
						try await viewModel.disablePushNotifications {
							router.routeTo(.setupFlavours)
						}
					}
				} label: {
					Text("Nah, don't bother me")
						.font(.system(size: 14, weight: .medium))
						.foregroundStyle(Color("MainColor"))
					
				}.disabled(viewModel.isLoading)
			}
		}
		.frame(
			minWidth: 0,
			maxWidth: .infinity,
			minHeight: 0,
			maxHeight: .infinity
		)
		.navigationBarBackButtonHidden(true)
		.background(Color("Background"))
		.onAppear {
			Task {
				viewModel.checkNotificationPermission()
				
				if viewModel.hasPermission {
					router.routeTo(.setupFlavours)
				}
			}

		}
		
	}
}

#Preview {
	@Previewable @State  var route: OnboardingRoutes? = nil
	let router = Router<OnboardingRoutes>(isPresented: Binding(projectedValue: $route))
	
	EnablePushNotificationsScreen(router: router)
}
