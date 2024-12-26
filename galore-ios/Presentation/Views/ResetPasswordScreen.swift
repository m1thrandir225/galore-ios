//
//  ResetPasswordScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.12.24.
//
import SwiftUI

struct ResetPasswordScreen : View {
	@StateObject var router: Router<AuthRoutes>
	
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
					viewModel.resetPassword {
						router.routeTo(.login)
					}
				} label: {
					Text("Reset Password")
						.font(.system(size: 16, weight: .semibold))
						.frame(maxWidth: .infinity)
						.padding()
						.background(Color("MainColor"))
						.foregroundStyle(Color("OnMain"))
						.clipShape(RoundedRectangle(cornerRadius: 16))
				}
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
	
	ResetPasswordScreen(router: router)
}
