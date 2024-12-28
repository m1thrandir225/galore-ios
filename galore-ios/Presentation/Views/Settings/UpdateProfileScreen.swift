//
//  UpdateProfileScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.11.24.
//

import SwiftUI

struct UpdateProfileScreen: View {
	@StateObject var router: Router<TabRoutes>
	@StateObject var viewModel: UpdateProfileViewModel = UpdateProfileViewModel()
	
	func isEmailValid() -> Bool {
		let emailTest = NSPredicate(format: "SELF MATCHES %@", "^\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}$")
		return emailTest.evaluate(with: viewModel.email)
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			BackButton {
				router.dismiss()
			}
			SectionTitle(text: "User Preferences")
			

			VStack (alignment: .center, spacing: 16){
				if let imageModel = viewModel.imageModel {
					EditableCircularProfileImage(viewModel: imageModel)
						.onChange(of: imageModel.imageState) { oldState, newState in
							switch newState {
							case .success(_):
								if let file = imageModel.networkFile {
									viewModel.networkFile = file // Update Binding when image successfully loaded
								}
							default:
								break // Ignore in this context.
							}
						}
				}
				TextField(
					"Your Name",
					text: $viewModel.name
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color("Outline"), lineWidth: 1.5)
					)
					.keyboardType(.default)
					.autocapitalization(.none)
				
				TextField(
					"Your Email",
					text: $viewModel.email
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color("Outline"), lineWidth: 1.5)
					)
					.keyboardType(.emailAddress)
					.textInputAutocapitalization(.never)
				
				if let birthday = viewModel.birthday {
					DatePickerOptional("Birthday", prompt: "Add Date", in: ...Date(), selection: $viewModel.birthday,showDate: true ,initialDate: birthday)
				}
				Button {
					Task {
						await viewModel.updateProfile {
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
							Text("Update profile")
								.font(.system(size: 18, weight: .semibold))
						}
					}
					.frame(maxWidth: .infinity) // Keeps the button width consistent
					.padding()
					.foregroundStyle(Color("OnMain"))
					.background(Color("MainColor"))
					.clipShape(RoundedRectangle(cornerRadius: 16))
				}
				.disabled(viewModel.isLoading)
				
			}
			if let errorMesage = viewModel.errorMesage {
				ErrorMessage(text: errorMesage)
			}
			if let successMessage = viewModel.successMessage {
				Text(successMessage)
					.font(.system(size: 24, weight: .bold))
					.foregroundStyle(Color("Teritary"))
			}
			Spacer()
		}
		.padding(24)
		.background(Color("Background"))
		.navigationBarBackButtonHidden(true)
		.task {
			viewModel.loadInitialData()
		}
	}
}

#Preview {
	@Previewable @State  var route: TabRoutes? = nil
	let router = Router<TabRoutes>(isPresented: Binding(projectedValue: $route))
	UpdateProfileScreen(router: router)
}
