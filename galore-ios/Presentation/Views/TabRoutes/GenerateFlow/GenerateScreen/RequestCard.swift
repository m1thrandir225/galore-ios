//
//  RequestCard.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 2.1.25.
//
import SwiftUI

struct RequestCard: View {
	let request: GenerateCocktailRequest
	let indexInList: Int
	   
	   var body: some View {
		   HStack(spacing: 12) {
			   // Status indicator dot
			   Circle()
				   .fill(statusColor)
				   .frame(width: 8, height: 8)
			   
			   // Main content
			   VStack(alignment: .leading, spacing: 4) {
				   Text("Generation Request #\(indexInList)")
					   .lineLimit(1)
					   .foregroundStyle(Color("OnBackground"))
				   
				   if request.status == "error" {
					   Text("Failed")
						   .font(.caption)
						   .foregroundColor(.red)
				   } else {
					   Text(statusDescription)
						   .font(.caption)
						   .foregroundColor(Color("OnBackground").opacity(0.5))
				   }
			   }
			   
			   Spacer()
			   if request.status != "error" {
				   ProgressView()
					   .tint(statusColor)
			   }
		   }
		   .padding(8)
		   .clipShape(RoundedRectangle(cornerRadius: 12))
		   .shadow(radius: 5)
		   .transition(.push(from: .leading).combined(with: .opacity))
		   
	   }
		
	   
	   private var statusColor: Color {
		   switch request.status.lowercased() {
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
	
	private var statusDescription: String {
		switch request.status.lowercased() {
		case "generating_cocktail":
			return "Generating a unique concoctioun"
		case "generating_images":
			return "Drawing instruction images"
		case "error":
			return "Something went wrong.."
		default:
			return ""
		}
	}
}

#Preview {
	let request = GenerateCocktailRequest(
		id: "1",
		   userId: "user_101",
		   prompt: "Create a cocktail with pineapple and rum.",
		   status: "generating_images",
		   errorMessage: nil,
		   updatedAt: "2025-01-01T12:00:00Z",
		   createdAt: "2025-01-01T11:00:00Z"
	   )
	RequestCard(request: request, indexInList: 1)
}
