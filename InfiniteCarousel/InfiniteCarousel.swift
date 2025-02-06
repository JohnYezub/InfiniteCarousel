//
//  InfiniteCarousel.swift
//  InfiniteCarousel
//
//  Created by Mr.John on 06/02/25.
//

import SwiftUI

struct InfiniteCarousel: View {
	static let animationDuration: CGFloat = 0.1

	@StateObject private var viewModel: ViewModel = .init()

	private let pageWidth: CGFloat = UIScreen.main.bounds.width - 16
	private let animation: Animation = .linear(duration: animationDuration)

	var body: some View {
		VStack(spacing: 20) {
			ScrollView(.horizontal) {
				LazyHStack(spacing: 0) {
					ForEach(viewModel.tempItems.indices, id: \.self) { idx in

						Text(viewModel.tempItems[idx].description)
							.foregroundStyle(.black)
							.font(.system(size: 24, weight: .bold))
							.frame(width: pageWidth, height: pageWidth)
							.background(
								RoundedRectangle(cornerRadius: 16)
									.fill(viewModel.tempItems[idx])

							)
							.padding(.horizontal, 8)
							.id(idx)
					}
				}
				.scrollTargetLayout()
			}
			.id(viewModel.tempItems.count)
			.frame(height: pageWidth)
			.scrollPosition(id: $viewModel.scrollPosition, anchor: .center)
			.scrollIndicators(.hidden)
			.scrollTargetBehavior(.paging)

			Text(viewModel.scrollPosition ?? 0, format: .number)
			Text(viewModel.text)

			HStack {
				ForEach(viewModel.colors.indices, id: \.self) { idx in
					Button(action: {
						withAnimation(animation) {
							viewModel.scrollPosition = idx + 1
						}
					}, label: {
						VStack {
							Circle()
								.fill(Color.gray.opacity((idx + 1 == (viewModel.scrollPosition ?? 0)) ? 1 : 0.3))
								.frame(width: 16, height: 16)
							Text("\(idx)")

						}
					})
				}
			}

		}
	}
}

#Preview {
	InfiniteCarousel()
}
