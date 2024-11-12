//
//  Logo.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 12.11.24.
//
import SwiftUI

struct Logo: View {
	var body: some View {
		Text("galore")
			.font(.system(size: 46))
			.fontWeight(.heavy)
			.foregroundColor(Color("MainColor"))
	}
}


#Preview {
	Logo()
}
