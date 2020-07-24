//
//  Cardify.swift
//  Memorize
//
//  Created by Max Matiushchenko on 20.07.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
	
	var rotation: Double
	
	init(isFaceUp: Bool) {
		rotation = isFaceUp ? 0 : 180
	}
	
	var isFaceUp: Bool {
		rotation < 90
	}
	
	var animatableData: Double {
		get { return rotation }
		set { rotation = newValue }
	}
	
	func body(content: Content) -> some View {
		ZStack {
			Group {
				RoundedRectangle(cornerRadius: raduisOfCorner).fill(Color.white)
				RoundedRectangle(cornerRadius: raduisOfCorner).stroke(lineWidth: edgeLineWidth)
				content
			}.opacity(isFaceUp ? 1 : 0)
			RoundedRectangle(cornerRadius: raduisOfCorner).fill()
				.opacity(isFaceUp ? 0 : 1)
		}
	}
	
	private let raduisOfCorner: CGFloat = 10.0
	private let edgeLineWidth: CGFloat = 3.0
}

extension View {
	func cardify(isFaceUp: Bool) -> some View {
		self.modifier(Cardify(isFaceUp: isFaceUp))
	}
}
