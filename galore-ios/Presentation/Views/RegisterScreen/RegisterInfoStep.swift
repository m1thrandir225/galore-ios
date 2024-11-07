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
	
	var body: some View {
		VStack(alignment: .leading, spacing: 24) {
			Text("Register")
				.font(.largeTitle)
			TextField(
				"",
				text: $name,
				prompt: Text("Your Name").foregroundStyle(.onBackground)
			).padding(.all, 20)
				.overlay(
					RoundedRectangle(cornerRadius: 8)
						.stroke(Color.gray, lineWidth: 1.5)
				)
				.keyboardType(.default)

			TextField(
				"",
				text: $email,
				prompt: Text("Your Email").foregroundStyle(.onBackground)
			).padding(.all, 20)
				.overlay(
					RoundedRectangle(cornerRadius: 8)
						.stroke(Color.gray, lineWidth: 1.5)
				)
			.keyboardType(.emailAddress)
			
			SecureField(
				"",
				text: $password,
				prompt: Text("Your Password").foregroundStyle(.onBackground)
			)
				.padding(.all, 20)
					.overlay(
						RoundedRectangle(cornerRadius: 8)
							.stroke(Color.gray, lineWidth: 1.5)
					)
		}
		.padding(.all, 20)
		Spacer()
	}
}
