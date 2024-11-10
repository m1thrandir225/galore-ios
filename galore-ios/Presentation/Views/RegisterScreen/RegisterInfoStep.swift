//
//  RegisterInfoStep.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 7.11.24.
//


import SwiftUI
import Lottie

struct RegisterInfoStep : View {
	@Binding var name: String
	@Binding var email: String
	@Binding var password: String
	
	@FocusState private var focus: Field?
	
	private enum Field: Int, Hashable, CaseIterable {
		case name
		case email
		case password
	}
	private func nextField() {
		guard let currentInput = focus,
				let lastIndex = Field.allCases.last?.rawValue else { return }
		
		let index = min(currentInput.rawValue + 1, lastIndex)
		self.focus = Field(rawValue: index)
	}
	
	private func previousField() {
		guard let currentInput = focus,
			  let firstIndex = Field.allCases.first?.rawValue else { return }
		
		let index = max(currentInput.rawValue - 1, firstIndex)
		self.focus = Field(rawValue: index)
	}
	
	private func dismissKeyboard() {
		self.focus = nil
	}
	
	func isEmailValid() -> Bool {
		let emailTest = NSPredicate(format: "SELF MATCHES %@", "^\\w+@[a-zA-Z_]+?\\.[a-zA-Z]{2,3}$")
		return emailTest.evaluate(with: email) 
	}
	
	func isPasswordValid() -> Bool {
		let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^([a-zA-Z0-9@*#]{8,15})$")
		return passwordTest.evaluate(with: password)
	}
	
	var namePrompt: String {
		if !name.isEmpty && name.count < 3 {
			return "Please enter your full name"
		} else {
			return ""
		}
	}
	
	var emailPrompt: String {
		if isEmailValid() {
			return ""
		} else {
			return "Please enter a valid email address"
		}
	}
	var passwordPrompt: String {
		if isPasswordValid() {
			return ""
		} else {
			return "Must be at least 8 characters and not more than 15."
		}
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			Text("Register")
				.font(.largeTitle)
			
			VStack(alignment: .leading) {
				TextField(
					"Your Name",
					text: $name
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray, lineWidth: 1.5)
					)
					.keyboardType(.default)
					.autocapitalization(.none)
					.focused($focus, equals: Field.name)
				
				if !name.isEmpty {
					Text(namePrompt).font(.caption).foregroundStyle(Color("Error"))
						.fontWeight(.semibold).transition(.scale)
				}
				
			}
			
			VStack(alignment: .leading) {
				TextField(
					"Your Email",
					text: $email
				).padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray, lineWidth: 1.5)
					)
					.keyboardType(.emailAddress)
					.focused($focus, equals: Field.email)
				
				if !email.isEmpty {
					Text(emailPrompt).font(.caption).foregroundStyle(Color("Error"))
						.fontWeight(.semibold).transition(.scale)
				}
				
			}
			VStack(alignment: .leading) {
				SecureField(
					"Your Password",
					text: $password
				)
				.padding(.all, 20)
				.overlay(
					RoundedRectangle(cornerRadius: 8)
						.stroke(Color.gray, lineWidth: 1.5)
				)
				.focused($focus, equals: Field.password)
				
				if !password.isEmpty {
					Text(passwordPrompt).font(.caption).foregroundStyle(Color("Error"))
						.fontWeight(.semibold).transition(.scale)
				}
				
			}
		}
		.toolbar {
			ToolbarItemGroup(placement: .keyboard) {
				Button {
					dismissKeyboard()
				} label: {
					Image(systemName: "xmark")
				}
				
				Spacer()
				
				Button {
					previousField()
				} label: {
					Image(systemName: "chevron.up")
				}
				
				Button {
					nextField()
				} label: {
					Image(systemName: "chevron.down")
				}
			}
		}
		.padding(.all, 20)
		Spacer()
	}
}
