//
//  WelcomeScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 26.10.24.
//

import SwiftUI

struct WelcomeScreen: View {
	var body: some View {
		   ZStack {
			   // Background image
			   Image("WelcomeBackground")
				   .resizable()
				   .scaledToFill()
				   .edgesIgnoringSafeArea(.all)
			   
			   // Overlay for darkening the image
			   Color.black.opacity(0.5)
				   .edgesIgnoringSafeArea(.all)
			   
			   VStack {
				   Spacer()
				   // Title and Subtitle
				   VStack {
					   Text("Welcome to")
						   .font(.system(size: 48))
						   .fontWeight(.bold)
						   .foregroundColor(.white)
					   Text("galore")
						   .font(.system(size: 46))
						   .fontWeight(.heavy)
						   .offset(CGSize(width: 0, height: -24))
						   .foregroundColor(Color("Primary"))
					   
					   Text("Become your own mixology master")
						   .font(.subheadline)
						   .foregroundColor(Color("Primary"))
						   .opacity(0.8)
				   }
				   .padding(.bottom, 32)
				   NavigationLink(destination: LoginScreen()) {
					   Text("Get Started")
						   .font(.headline)
						   .foregroundColor(.white)
						   .padding()
						   .frame(maxWidth: 200)
						   .background(Color("Primary"))
						   .cornerRadius(12)
				   }.padding(.bottom)
			   }
		   }
	   }
}

#Preview {
    WelcomeScreen()
}
