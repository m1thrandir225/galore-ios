//
//  StatusBadge.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//

import SwiftUI

struct StatusBadge: View {
	let status: String
	
	var body: some View {
		Text(status)
			.font(.caption)
			.padding(.horizontal, 8)
			.padding(.vertical, 4)
			.background(backgroundColor)
			.foregroundColor(.white)
			.cornerRadius(8)
	}
	
	private var backgroundColor: Color {
		switch status.lowercased() {
		case "generating_cocktail":
			return .blue
		case "generating_images":
			return .purple
		case "error":
			return .red
		default:
			return .gray
		}
	}
}
#Preview {
	StatusBadge(status: "generating recipe")
}
