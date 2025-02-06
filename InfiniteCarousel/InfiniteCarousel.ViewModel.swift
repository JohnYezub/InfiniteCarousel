//
//  ViewModel.swift
//  InfiniteCarousel
//
//  Created by Mr.John on 06/02/25.
//

import SwiftUI
import Combine

extension InfiniteCarousel {
	class ViewModel: ObservableObject {
		// Bindings
		@Published var scrollPosition: Int?

		//Published
		@Published private(set) var tempItems: [Color] = []
		@Published private(set) var text: String = ""

		let colors: [Color]	= [.red, .blue, .green, .yellow]

		private var cancellables: Set<AnyCancellable> = []

		init() {
			tempItems = colors
			tempItems.append(colors.first!)
			tempItems.insert(colors.last!, at: 0)

			scrollPosition = 1

			setupBindings()
		}

		private func setupBindings() {
			$scrollPosition
				.removeDuplicates()
				.sink { [weak self] idx in

				guard let self else {return}
				guard let idx else {return}

				let itemCount = tempItems.count
				self.text = ""

				if idx % itemCount == itemCount - 1  {
					self.text = "last"

					DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
						self.scrollPosition = 1
					}
					return
				}

				if idx % itemCount == 0  {
					self.text = "first"

					DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
						self.scrollPosition = itemCount - 2
					}
					return
				}
			}
			.store(in: &cancellables)
		}
	}
}
