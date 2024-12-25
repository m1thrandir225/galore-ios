//
//  HeartButton.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 15.11.24.
//
import SwiftUI

struct HeartButton: View {
	@State private var isScaled: Bool = false
	var onToggle: () -> Void
	var isPressed: Bool

	
	init(isPressed: Bool, onToggle: @escaping () -> Void) {
		self.isPressed = isPressed
		self.onToggle = onToggle
	}
	
	var body: some View {
		Button {
			Task {
				withAnimation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
					isScaled.toggle()
				}
				
				// Trigger haptic feedback
				let generator = UIImpactFeedbackGenerator(style: .medium)
				generator.impactOccurred()
				
				// Wait for 300ms before resetting the scale
				try? await Task.sleep(nanoseconds: 300_000_000)
				withAnimation {
					isScaled = false
				}
				onToggle()
			}
		} label: {
			Image(systemName: isPressed ? "heart.fill" : "heart")
				.foregroundStyle(Color.white)
				.padding()
				.background(Color("MainColor"))
				.clipShape(Circle())
				.scaleEffect(isScaled ? 1.2 : 1.0) // Scale effect
				.animation(.easeInOut(duration: 0.2), value: isScaled) // Smooth animation
		}
	}
}

#Preview {
	@Previewable @State var isPressed: Bool = false
	
	HeartButton(isPressed: isPressed) {
		isPressed.toggle()
	}
}
