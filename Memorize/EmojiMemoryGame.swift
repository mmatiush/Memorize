//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Max Matiushchenko on 24.05.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import SwiftUI

// ViewModel

class EmojiMemoryGame {
    private var model = createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "🕷"]
        return MemoryGame<String>(numberOfPairsOfCards: emojis.count) { (pairIndex) in
            return emojis[pairIndex]
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    func choose(card: MemoryGame<String>.Card) {
        model.chose(card: card)
    }
    
}
