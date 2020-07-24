//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Max Matiushchenko on 24.05.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import SwiftUI

// ViewModel

class EmojiMemoryGame: ObservableObject {
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { (pairIndex) in
            return emojis[pairIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func choose(card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.chose(card: card)
    }

	func resetGame() {
		model = EmojiMemoryGame.createMemoryGame()
	}
    
}
