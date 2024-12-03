import SwiftUI

struct TrackableScrollView<Header: View, Content: View>: View {
	@State private var showingHeader = true
	@State private var turningPoint = CGFloat.zero // ADDED
	let thresholdScrollDistance: CGFloat = 50 // ADDED
	let header: () -> Header
	let content: () -> Content
	
	var body: some View {
		VStack(spacing: 0) {
			if showingHeader {
				header()
					.transition(
						.asymmetric(
							insertion: .push(from: .top),
							removal: .push(from: .bottom)
						)
					)
			}
			
			GeometryReader { outerGeo in
				let outerHeight = outerGeo.size.height
				ScrollView(.vertical) {
					content()
						.background {
							GeometryReader { innerGeo in
								Color("Background")
									.onChange(of: innerGeo.frame(in: .named("ScrollView")).minY) { oldVal, newVal in
										if (showingHeader && newVal > oldVal) || (!showingHeader && newVal < oldVal) {
											turningPoint = newVal
										}
										if (showingHeader && (turningPoint - newVal) > thresholdScrollDistance) ||
											(!showingHeader && (newVal - turningPoint) > thresholdScrollDistance) {
											showingHeader = newVal > turningPoint
										}
									}
							}
						}
				}
				.coordinateSpace(name: "ScrollView")
			}
		}
		.background(Color("Background"))
		.animation(.easeInOut(duration: 0.2), value: showingHeader)
	}
}
