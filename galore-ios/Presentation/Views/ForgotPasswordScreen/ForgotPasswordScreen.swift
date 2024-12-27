//
//  ForgotPasswordScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 31.10.24.
//

import SwiftUI

enum ForgotPasswordSteps : CaseIterable {
	case enterEmail
	case enterCode
	case success
}

struct ForgotPasswordScreen: View {
	@StateObject var router: Router<AuthRoutes>
	@StateObject var viewModel: ForgotPasswordViewModel = ForgotPasswordViewModel()
	
	@State var step: ForgotPasswordSteps = .enterEmail
	@State private var showAlert: Bool = false
	@State private var alertMessage: String = ""
	
	let resetPasswordExpiredError = "reset password request has expired"

	private func getStepProgressValue() -> Float {
		switch step {
		case .enterEmail:
			return 0
		case .enterCode:
			return 0.5
		case .success:
			return 1
		}
	}
    var body: some View {
		VStack(alignment: .leading) {
			VStack(alignment: .leading) {
				Logo()
			}.frame(maxWidth: .infinity)
			BackButton {
				router.dismiss()
			}.padding(.horizontal, 24)
			
			Spacer()
			VStack(alignment: .leading, spacing: 24) {
				Text("Forgot your password?")
					.font(.system(size: 32, weight: .bold))
					.foregroundStyle(Color("MainColor"))
					.padding(.bottom, 12)
				
				
				switch step {
				case .enterEmail:
					ForgotPasswordEnterEmailStep(email: $viewModel.email, isLoading: $viewModel.isLoading) {
						Task {
							try await viewModel.sendForgotPasswordRequest {
								step = .enterCode
							}
						}
						
					}
				case .enterCode:
					ForgotPasswordEnterCodeStep(code: $viewModel.code, isLoading: $viewModel.isLoading) {
						Task {
							try await viewModel.sendVerifyOTPRequest {
								step = .success
							}
						}
					}
				case .success:
					VStack(alignment: .center) {
						ProgressView()
							.task{
								try? await Task.sleep(nanoseconds: 1500000000)
								if let resetPasswordRequest = viewModel.passwordChangeRequest {
									router.routeTo(.resetPassword(ResetPasswordArgs(resetPasswordRequest: resetPasswordRequest)))
								}
					
								
							}
					}.frame(maxWidth: .infinity)
			
				}
			}
			.padding(24)
			.animation(.smooth, value: step)
			
			Spacer()
			VStack(spacing: 24) {
				if let errorMessage = viewModel.errorMessage {
					Text("Error: \(errorMessage)")
						.font(.system(size: 16, weight: .semibold))
						.foregroundColor(Color("Error"))
						.transition(.slide.combined(with: .scale))
						.animation(.smooth, value: viewModel.errorMessage)
				}
				ProgressView(value: getStepProgressValue())
					.progressViewStyle(LinearProgressViewStyle(tint: Color("MainColor")))
					.animation(.smooth, value: step)
			}

			
			
			
			
		}
		.background(Color("Background"))
		.navigationBarBackButtonHidden(true)
		.onChange(of: viewModel.errorMessage) { oldErr, newErr in
			guard let errorMessage = newErr else { return }
			if resetPasswordExpiredError.contains(errorMessage) {
				alertMessage = "The reset password request has expired. Please try again!"
				showAlert = true
			}
		}
		.alert(isPresented: $showAlert) {
			Alert(
				title: Text("Request Expired"),
				message: Text(alertMessage),
				dismissButton: .default(Text("OK"), action: {
					router.popUntil(.login)
				})
			)
		}
    }
}

#Preview {
	@Previewable @State  var authRoute: AuthRoutes? = nil
	let router = Router<AuthRoutes>(isPresented: Binding(projectedValue: $authRoute))
	
	ForgotPasswordScreen(router: router)
}
