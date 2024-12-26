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
					ForgotPasswordEnterEmailStep(email: $viewModel.email) {
						step = .enterCode
					}
				case .enterCode:
					ForgotPasswordEnterCodeStep(code: $viewModel.code) {
						step = .success
					}
				case .success:
					VStack(alignment: .center) {
						ProgressView()
							.task{
								try? await Task.sleep(nanoseconds: 1500000000)
								router.routeTo(.resetPassword)
								
							}
					}.frame(maxWidth: .infinity)
			
				}
			}
			.padding(24)
			.animation(.smooth, value: step)
			
			Spacer()
			ProgressView(value: getStepProgressValue())
				.progressViewStyle(LinearProgressViewStyle(tint: Color("MainColor")))
				.animation(.smooth, value: step)
			
			
			
			
		}
		.background(Color("Background"))
		.navigationBarBackButtonHidden(true)
    }
}

#Preview {
	@Previewable @State  var authRoute: AuthRoutes? = nil
	let router = Router<AuthRoutes>(isPresented: Binding(projectedValue: $authRoute))
	
	ForgotPasswordScreen(router: router)
}
