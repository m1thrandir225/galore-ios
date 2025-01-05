//
//  TitleVisibilityCheckerView.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 28.12.24.
//


import SwiftUI

struct TitleVisibilityCheckerView: View {
	let title: String
	@Binding var titleVisible: Bool
	
	var body: some View {
		GeometryReader { geometry in
			Text(title)
				.font(.system(size: 28, weight: .bold))
				.multilineTextAlignment(.leading)
				.foregroundStyle(Color("OnBackground"))
				.padding(24)
				.opacity(titleVisible ? 1 : 0)
				.animation(.easeInOut, value: titleVisible)
				.onChange(of: geometry.frame(in: .global).minY) { _, newValue in
					let threshold: CGFloat = 50 // Adjust this based on when you want the header to appear
					if newValue <= threshold && titleVisible {
						// Once scrolled out of view, make the header title appear
						titleVisible = false
					} else if newValue > threshold && !titleVisible {
						// Make the initial title visible again
						titleVisible = true
					}
				}
		}
		.frame(height: 100)
	}
}

#Preview {
	@Previewable @State var titleVisible = true
	TitleVisibilityCheckerView(title: "Your Generated Cocktails", titleVisible: $titleVisible)
}
