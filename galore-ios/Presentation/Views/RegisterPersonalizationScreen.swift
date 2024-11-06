//
//  RegisterPersonalizationScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//

import SwiftUI
import Lottie

struct RegisterPersonalizationScreen: View {
	@State var birthday: Date?
	@State var avatarURL: String?
	
	@StateObject var imageViewModel = ProfileModel()

	
	@StateObject var router: Router<Routes>
    var body: some View {
		VStack {
			VStack(alignment: .center, spacing: 12) {
				Text("galore")
					.font(.system(size: 46))
					.fontWeight(.heavy)
					.foregroundColor(Color("MainColor"))
				
				LottieView(animation: .named("registerLottie"))
					.playing(loopMode: .loop)
					.scaledToFill()
					.frame(height: 150)
			}
			VStack(alignment: .center, spacing: 24) {
				EditableCircularProfileImage(viewModel: imageViewModel)
				DatePickerOptional("Birthday", prompt: "Add Date", in: ...Date(), selection: $birthday)
			}
			.padding(.all, 20)
			
			Spacer(minLength: 64.0)
			
			VStack(alignment: .center, spacing: 24){
				Button(action: {
					print("Hello World")
				}) {
					Text("Continue")
						.font(.headline)
						.foregroundColor(.white)
						.padding(.all, 14)
						.frame(maxWidth: .infinity)
						.background(Color("MainColor"))
						.cornerRadius(24)
				}.padding([.leading, .trailing], 24)
				
				HStack {
					Text("Already have an account?")
					Button(action: {
						router.replace(.login)
					}) {
						Text("Login")
							.foregroundColor(Color("MainColor"))
							.fontWeight(.bold)
					}
					
				}
			}
			
			Spacer()

			
		}.background(Color("Background"))    }
}

#Preview {
	@Previewable @State  var authRoute: Routes? = nil
	let router = Router<Routes>(isPresented: Binding(projectedValue: $authRoute))
	
	RegisterPersonalizationScreen(router: router)
}
