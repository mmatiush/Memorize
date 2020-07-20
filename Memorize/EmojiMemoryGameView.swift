//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Max Matiushchenko on 22.05.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import SwiftUI

// Creates structure of window view
struct EmojiMemoryGameView: View {
	@ObservedObject var viewModel: EmojiMemoryGame
	
	var body: some View {
		Grid(viewModel.cards) { card in
			CardView(card: card).onTapGesture {
				self.viewModel.choose(card: card)
			}
			.padding(5)
		}
		.padding()
		.foregroundColor(Color.orange)
	}
}

// Describes how each cardView should look like. Sets card content
struct CardView: View {
	var card: MemoryGame<String>.Card
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				if self.card.isFaceUp {
					RoundedRectangle(cornerRadius: raduisOfCorner).fill(Color.white)
					RoundedRectangle(cornerRadius: raduisOfCorner).stroke(lineWidth: edgeLineWidth)
					Text(self.card.content)
				} else {
					if !self.card.isMatched {
						RoundedRectangle(cornerRadius: raduisOfCorner).fill()
					}
				}
			}
			.font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
		}
	}
}

// MARK: - Drawing constants

let raduisOfCorner: CGFloat = 10.0
let edgeLineWidth: CGFloat = 3.0
let fontScaleFactor: CGFloat = 0.75












struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		EmojiMemoryGameView(viewModel: EmojiMemoryGame())
	}
}
