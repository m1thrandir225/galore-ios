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
			Spacer()
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
					
					.padding(24)
					.tag(index)
					
				}
			}
			.tabViewStyle(.page(indexDisplayMode: .never))
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
			.frame(height: 500)
			
			HStack(spacing: 8) {
				ForEach(slides.indices, id: \.self) { index in
					RoundedRectangle(cornerRadius: 24)
						.fill(index == currentIndex ? Color("MainColor") : Color.gray.opacity(0.4))
						.frame(width: index == currentIndex ? 16 : 8, height: 8)
						.animation(.spring(duration: 0.3, bounce: 0.5, blendDuration: 0), value: currentIndex)
				}
			}
			
			Spacer()
			HStack {
				Button {
					if (currentIndex < slides.count-1) {
						currentIndex+=1
					} else {
						router.routeTo(.enableNotifications)
					}
				} label: {
					Text(currentIndex == slides.count-1 ? "Continue" : "\(Image(systemName: "arrow.right"))")
						.frame(maxWidth: currentIndex == slides.count-1 ? .infinity : 50)
						.padding()
						.font(.system(size: 24, weight: .semibold))
						.foregroundStyle(Color("OnMain"))
						.background(Color("MainColor"))
						.clipShape(
							RoundedRectangle(cornerRadius: currentIndex == slides.count-1 ? 16 : 50)
						)
						.animation(.spring(duration: 0.3, bounce: 0.5, blendDuration: 0), value: currentIndex)
					
					
					
				}
			}.padding(24)
			Spacer()
			
		}
		.background(Color("Background"))
		.frame(
			minWidth: 0,
			maxWidth: .infinity,
			minHeight: 0,
			maxHeight: .infinity
		)
		.navigationBarBackButtonHidden(true)
	}
}

#Preview {
	@Previewable @State  var route: OnboardingRoutes? = nil
	let router = Router<OnboardingRoutes>(isPresented: Binding(projectedValue: $route))
	
	ShowcaseScreen(router: router)
}
