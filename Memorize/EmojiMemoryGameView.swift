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
		VStack {
			Grid(viewModel.cards) { card in
				CardView(card: card).onTapGesture {
					withAnimation(.linear(duration: 0.75)) {
						self.viewModel.choose(card: card)
					}
				}
				.padding(5)
			}
			.padding()
			.foregroundColor(Color.orange)
			
			Button(action: {
				withAnimation(Animation.easeInOut(duration: 3)) {
					self.viewModel.resetGame()
				}
			}) { Text("New Game") }
		}
	}
}

// Describes how each cardView should look like. Sets card content
struct CardView: View {
	var card: MemoryGame<String>.Card
	
	@State private var animateBonusRemaining: Double = 0
	
	private func startBonusTimeAnimation() {
		animateBonusRemaining = card.bonusRemaining
		withAnimation(.linear(duration: card.bonusTimeLimit)) {
			animateBonusRemaining = 0
		}
	}
	
	var body: some View {
		GeometryReader { geometry in
			if self.card.isFaceUp || !self.card.isMatched {
				ZStack {
					Group {
						if self.card.isConsumingBonusTime {
							Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle.degrees( -self.animateBonusRemaining*360-90), clockwise: true)
								.onAppear {
									self.startBonusTimeAnimation()
							}
						} else {
							Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle.degrees( -self.card.bonusRemaining*360-90), clockwise: true)
						}
					}
					.padding(5)
					.opacity(0.4)
					
					Text(self.card.content)
						.font(Font.system(size: min(geometry.size.width, geometry.size.height) * fontScaleFactor))
						.rotationEffect(Angle.degrees(self.card.isMatched ? 360 : 0))
						.animation(self.card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
					
				}
				.cardify(isFaceUp: self.card.isFaceUp)
				.transition(AnyTransition.scale)
				.rotation3DEffect(Angle.degrees(self.card.isFaceUp ? 0 : 180), axis: (0,1,0))
			}
		}
		
	}
}

// MARK: - Drawing constants

private let fontScaleFactor: CGFloat = 0.7

































struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let game = EmojiMemoryGame()
		game.choose(card: game.cards[0])
		return EmojiMemoryGameView(viewModel: game)
	}
}
