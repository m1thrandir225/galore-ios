//
//  ResetPasswordScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import SwiftUI

struct ResetPasswordScreen : View {
	@StateObject var router: Router<AuthRoutes>
	
	let resetPasswordRequest: ResetPasswordModel
	
	@StateObject var viewModel: ResetPasswordViewModel = ResetPasswordViewModel()
	
	var body: some View {
		VStack(alignment: .leading) {
			VStack(alignment: .leading) {
				Logo()
			}.frame(maxWidth: .infinity)
			
			Spacer()
			VStack(alignment: .leading,spacing: 24) {
				Text("Reset your password")
					.font(.system(size: 32, weight: .bold))
					.foregroundStyle(Color("MainColor"))
					.padding(.bottom, 12)
				VStack (alignment: .leading, spacing: 12) {
					Text("New Password")
						.foregroundStyle(Color("Secondary"))
						.font(.system(size: 16, weight: .semibold))
					PasswordField(text: $viewModel.newPassword, placeholder: "Enter your new password")
				}
				VStack (alignment: .leading, spacing: 12) {
					Text("Confirm Password")
						.foregroundStyle(Color("Secondary"))
						.font(.system(size: 16, weight: .semibold))
					PasswordField(text: $viewModel.confirmPassword, placeholder: "Repeat your new password")
				}
				Button {
					Task {
						 await viewModel.resetPassword(resetPasswordRequestId: resetPasswordRequest.id ){
							router.routeTo(.login)
						}
					}

				} label: {
					ZStack {
						if viewModel.isLoading {
							ProgressView()
								.progressViewStyle(CircularProgressViewStyle(tint: (Color("OnMain"))))
								.foregroundColor(Color("OnMain"))
							
							
						} else {
							Text("Continue")
								.font(.system(size: 18, weight: .semibold))
						}
					}
					.frame(maxWidth: .infinity)
					.padding()
					.foregroundStyle(Color("OnMain"))
					.background(Color("MainColor"))
					.clipShape(RoundedRectangle(cornerRadius: 16))
				}
				.disabled(viewModel.isLoading)
			}.padding(24)

			Spacer()
		}
		.background(Color("Background"))
		.navigationBarBackButtonHidden(true)
	}
}

#Preview {
	@Previewable @State  var authRoute: AuthRoutes? = nil
	let router = Router<AuthRoutes>(isPresented: Binding(projectedValue: $authRoute))
	
//	ResetPasswordScreen(router: router, reset)
}
