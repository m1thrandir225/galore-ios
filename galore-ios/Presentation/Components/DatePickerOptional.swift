//
//  DatePickerOptional.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 6.11.24.
//
import SwiftUI
import Foundation

struct DatePickerOptional: View {
	
	let label: String
	let prompt: String
	let range: PartialRangeThrough<Date>
	@Binding var date: Date?
	@State private var hidenDate: Date = Date()
	@State private var showDate: Bool = false
	
	init(_ label: String, prompt: String, in range: PartialRangeThrough<Date>, selection: Binding<Date?>) {
		self.label = label
		self.prompt = prompt
		self.range = range
		self._date = selection
	}
	
	var body: some View {
		ZStack {
			HStack {
				Text(label)
					.fontWeight(.bold)
					.multilineTextAlignment(.leading)
				Spacer()
				if showDate {

					DatePicker(
						label,
						selection: $hidenDate,
						in: range,
						displayedComponents: .date
					)
					.labelsHidden()
					.onChange(of: hidenDate) { newDate in
						date = newDate
					}
					Button {
						showDate = false
						date = nil
					} label: {
						Image(systemName: "xmark.circle")
							.resizable()
							.frame(width: 16, height: 16)
							.tint(Color("MainColor"))
					}
					
				} else {
					Button {
						showDate = true
						date = hidenDate
					} label: {
						Text(prompt)
							.multilineTextAlignment(.center)
							.foregroundColor(Color("OnMain"))
					}
					.frame(width: 120, height: 34)
					.background(
						RoundedRectangle(cornerRadius: 8)
							.fill(Color("MainColor"))
					)
					.multilineTextAlignment(.trailing)
				}
			}
		}
	}
}
