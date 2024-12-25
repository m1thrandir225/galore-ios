//
//  ShowcaseScreen.swift
//  galore-ios
//
//  Created by Sebastijan Zindl on 25.12.24.
//
import SwiftUI

struct ShowcaseSlide {
	let image: String
	let description: String
}

struct ShowcaseScreen :  View {
	public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
	
	@StateObject var router: Router<OnboardingRoutes>
	@State var currentIndex: Int = 0
	
	let slides: [ShowcaseSlide] = [
		ShowcaseSlide(image: "OnboardingCarousel_1", description: "Choose your favourite flavours."),
		ShowcaseSlide(image: "OnboardingCarousel_2", description: "Find your next favourite drink."),
		ShowcaseSlide(image: "OnboardingCarousel_3", description: "Generate your own unique cocktail.")
	]
	
	var body: some View {
		VStack(alignment: .center ,spacing: 10) {
			TabView(selection: $currentIndex) {
				ForEach(slides.indices, id: \.description) { index in
					VStack {
						Image(slides[index].image)
							.resizable()
							.scaledToFit()
							.frame(height: 300)
						Text(slides[index].description)
							.font(.system(size: 26, weight: .semibold))
							.foregroundStyle(Color("OnBackground"))
							.transition(.blurReplace)
					}
					.background(.red)
					.padding(24)
					.tag(index)
					
				}
			}
			.tabViewStyle(PageTabViewStyle())
			.gesture(
				DragGesture()
					.onEnded { gesture in
						if gesture.translation.width < 0 {
							// Swipe left
							withAnimation {
								currentIndex = (currentIndex + 1) % slides.count
							}
						} else if gesture.translation.width > 0 {
							// Swipe right
							withAnimation {
								currentIndex = (currentIndex - 1 + slides.count) % slides.count
							}
						}
					}
			)
			.onReceive(timer) { _ in
				withAnimation {
					currentIndex = (currentIndex + 1) % slides.count
				}
			}.frame(height: 500)
			HStack(spacing: 8) {
				ForEach(slides.indices, id: \.self) { index in
					Circle()
						.fill(index == currentIndex ? Color("MainColor") : Color.gray.opacity(0.4))
						.frame(width: 8, height: 8)
				}
			}
			
		}.background(Color("Background"))
	}
}

#Preview {
	@Previewable @State  var route: OnboardingRoutes? = nil
	let router = Router<OnboardingRoutes>(isPresented: Binding(projectedValue: $route))
	
	ShowcaseScreen(router: router)
}
