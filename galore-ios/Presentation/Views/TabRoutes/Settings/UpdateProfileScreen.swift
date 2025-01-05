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
	
	func isEmailValid(email: String) -> Bool {
		let emailTest = NSPredicate(format: "SELF MATCHES %@", "^\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}$")
		return emailTest.evaluate(with: email)
	}
	
	func isNameValid(item: String) -> Bool {
		return item.count > 3 && !item.isEmpty
	}
	
	func isBirthdayValid(item: Date) -> Bool {
		return item < Date()
	}
	
	func isProfilePictureValid(imageModel: ProfilePictureModel) -> Bool {
		switch imageModel.imageState {
		case .empty, .failure:
			return false
		case .loading, .success:
			return true
		}
	}
	
	
	
	func emailPrompt(email: String) -> String {
		if isEmailValid(email: email) {
			return ""
		} else {
			return "Please enter a valid email."
		}
	}
	
	func namePrompt(name: String) -> String {
		if isNameValid(item: name) {
			return ""
		} else {
			return "Please enter a valid name."
		}
	}
	
	func birthdayPrompt(birthday: Date) -> String {
		if isBirthdayValid(item: birthday) {
			return ""
		} else {
			return "Please enter a valid date."
		}
	}
	
	func profilePicturePrompt(imageViewModel: ProfilePictureModel) -> String {
		if isProfilePictureValid(imageModel: imageViewModel) {
			return ""
		} else {
			return "Please select a valid picture."
		}
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			BackButton {
				router.dismiss()
			}
			SectionTitle(text: "User Preferences", fontSize: 32)
			
			if viewModel.isLoadingInitialData {
				ProgressView()
			} else {
				ScrollView (.vertical, showsIndicators: false ){
					VStack (alignment: .center, spacing: 16){
						if let imageModel = viewModel.imageModel {
							VStack(alignment: .center, spacing: 12) {
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
								Text(profilePicturePrompt(imageViewModel: imageModel))
									.font(.caption).foregroundStyle(Color("Error"))
									.fontWeight(.semibold).transition(.scale)
							}
						}
						VStack (alignment: .leading, spacing: 12) {
							Text("Name:")
								.font(.system(size: 20, weight: .semibold))
								.foregroundStyle(Color("MainColor"))
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
							
							if !viewModel.name.isEmpty {
								Text(namePrompt(name: viewModel.name))
									.font(.caption).foregroundStyle(Color("Error"))
									.fontWeight(.semibold).transition(.scale)
							}
						}
						
						VStack (alignment: .leading, spacing: 12) {
							Text("Email:")
								.font(.system(size: 20, weight: .semibold))
								.foregroundStyle(Color("MainColor"))
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
							
							if !viewModel.email.isEmpty {
								Text(emailPrompt(email: viewModel.email))
									.font(.caption).foregroundStyle(Color("Error"))
									.fontWeight(.semibold).transition(.scale)
							}
						}
						
						if let birthday = viewModel.birthday {
							VStack (alignment: .leading, spacing: 12) {
								DatePickerOptional(
									"Birthday",
									prompt: "Add Date",
									in: ...Date(),
									selection: $viewModel.birthday,
									showDate: true ,
									initialDate: birthday,
									allowClear: false
								)
								
								
								Text(birthdayPrompt(birthday: birthday))
									.font(.caption).foregroundStyle(Color("Error"))
									.fontWeight(.semibold).transition(.scale)
							}
							
						}
					}
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
				}
				.disabled(viewModel.isLoading)
				.buttonStyle(
					MainButtonStyle(isDisabled: viewModel.isLoading)
				)
				if let errorMesage = viewModel.errorMesage {
					ErrorMessage(text: errorMesage)
				}
				if let successMessage = viewModel.successMessage {
					Text(successMessage)
						.font(.system(size: 24, weight: .bold))
						.foregroundStyle(Color("Teritary"))
				}
			}
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
