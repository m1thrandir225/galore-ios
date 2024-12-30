//
//  ChangePasswordScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//

import SwiftUI

struct ChangePasswordScreen: View {
	@StateObject var router: Router<TabRoutes>
	
	@StateObject var viewModel: ChangePasswordViewModel = ChangePasswordViewModel()
	
	@State var resetPasswordAlertShowing: Bool = false
	@State var deleteAccountAlertShowing: Bool = false
	@State var alertTitle: String = ""
	@State var alertMessage: String = ""
	
	func isPasswordValid(password: String) -> Bool {
		let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9@*#]{8,15})$")
		return passwordTest.evaluate(with: password)
	}
	
	func newPassowrdPrompt(password: String) -> String {
		if isPasswordValid(password: password) {
			return ""
		} else {
			return "Please enter a valid password."
		}
	}
	
	func confirmPasswordPrompt(password: String) -> String {
		if isPasswordValid(password: password) && password == viewModel.password {
			return ""
		} else {
			return "Passwords do not match."
		}
	}
	 
	
	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			BackButton {
				router.dismiss()
			}
			SectionTitle(text: "Password & Security", fontSize: 38)
			VStack (alignment: .leading, spacing: 12) {
				Text("New Password")
					.foregroundStyle(Color("Secondary"))
					.font(.system(size: 16, weight: .semibold))
				PasswordField(text: $viewModel.password, placeholder: "Enter your new password")
				
				if !viewModel.password.isEmpty {
					Text(newPassowrdPrompt(password: viewModel.password))
						.font(.caption).foregroundStyle(Color("Error"))
						.fontWeight(.semibold).transition(.scale)
				}
			}
			VStack (alignment: .leading, spacing: 12) {
				Text("Confirm Password")
					.foregroundStyle(Color("Secondary"))
					.font(.system(size: 16, weight: .semibold))
				PasswordField(text: $viewModel.confirmPassword, placeholder: "Repeat your new password")
				if !viewModel.confirmPassword.isEmpty {
					Text(confirmPasswordPrompt(password: viewModel.confirmPassword))
						.font(.caption).foregroundStyle(Color("Error"))
						.fontWeight(.semibold).transition(.scale)
				}
			}
			Button {
				Task {
					await viewModel.changePassword {
						resetPasswordAlertShowing = true
						alertTitle = "Password Changed"
						alertMessage = "Your password has been changed successfully. Please log in again"
					}
				}
			} label: {
				ZStack {
					if viewModel.isLoading {
						ProgressView()
							.progressViewStyle(CircularProgressViewStyle(tint: (Color("OnMain"))))
							.foregroundColor(Color("OnMain"))
						
						
					} else {
						Text("Reset Password")
							.font(.system(size: 16, weight: .semibold))
					}
				}
				.frame(maxWidth: .infinity)
			}
			.disabled(
				viewModel.isLoading ||
				newPassowrdPrompt(password: viewModel.password).count > 0 ||
				confirmPasswordPrompt(password: viewModel.password).count > 0
			)
			.buttonStyle(
				MainButtonStyle(isDisabled: viewModel.isLoading ||
								newPassowrdPrompt(password: viewModel.password).count > 0 ||
					confirmPasswordPrompt(password: viewModel.password).count > 0)
			)
			
			
			if let errorMessage = viewModel.errorMessage {
				ErrorMessage(text: errorMessage)
			}
			
			Spacer()
			Button {
				deleteAccountAlertShowing = true
				alertTitle = "Delete Account"
				alertMessage = "Are you sure you want to delete your account?"
			} label: {
				ZStack {
					if viewModel.isDeleting {
						ProgressView()
							.progressViewStyle(CircularProgressViewStyle(tint: (Color("OnMain"))))
							.foregroundColor(Color("OnMain"))
						
						
					} else {
						HStack {
							Image(systemName: "trash")
							Text("Delete Account")
								.font(.system(size: 16, weight: .semibold))
						}
						
					}
				}
				.frame(maxWidth: .infinity)
				.padding()
				.foregroundStyle(Color.white)
				.background(Color.red)
				.clipShape(RoundedRectangle(cornerRadius: 16))
			}
			.disabled(viewModel.isDeleting)
		}
		.padding(24)
		.background(Color("Background"))
		.navigationBarBackButtonHidden(true)
		.alert(isPresented: $resetPasswordAlertShowing) {
			Alert(
				title: Text(alertTitle),
				message: Text(alertMessage),
				dismissButton: .default(Text("OK"))
			)
		}
		.alert(isPresented: $deleteAccountAlertShowing) {
			Alert(
				title: Text(alertTitle),
				message: Text(alertMessage),
				primaryButton: .destructive(Text("Yes"), action: {
					Task {
						await viewModel.deleteAccount()
					}
				}),
				secondaryButton: .cancel(Text("No"))
			)
		}
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	ChangePasswordScreen(router: router)
}
