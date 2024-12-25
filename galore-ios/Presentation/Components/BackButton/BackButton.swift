//
//  BackButton.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//

import SwiftUI

struct BackButton: View {
	@State private var isScaled: Bool = false
	
	var onTap: () -> Void
	
    var body: some View {
		Button {
			Task {
				withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
					isScaled.toggle()
				}
				
				let generator = UIImpactFeedbackGenerator(style: .medium)
				generator.impactOccurred()
				
				try? await Task.sleep(nanoseconds: 300_000_000)
				withAnimation {
					isScaled = false
				}
				onTap()
			}
			

			
			
		} label: {
			Image(systemName:  "arrow.left")
				.foregroundStyle(Color.white)
				.padding()
				.background(Color("MainColor"))
				.clipShape(Circle())
				.scaleEffect(isScaled ? 1.2 : 1.0)
				.animation(.easeInOut(duration: 0.2), value: isScaled)
		}
    }
}

#Preview {
	BackButton(onTap: {})
}
