//
//  MemoryGame.swift
//  Memorize
//
//  Created by Max Matiushchenko on 24.05.2020.
//  Copyright © 2020 Max Matiushchenko. All rights reserved.
//

import Foundation

// Model
// It's composed of array of Card objects and methods to manipulate the objects.
struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func chose(card: Card) {
        print("chosen card \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        
    }
    
    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
