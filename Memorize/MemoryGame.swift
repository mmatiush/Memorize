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
struct MemoryGame<CardContent> where CardContent: Equatable {
	var cards: Array<Card>
	
	var indexOfTheOneAndOnlyFaceUpCard: Int? {
		get { cards.indices.filter { cards[$0].isFaceUp }.only }
		set {
			for index in cards.indices {
				cards[index].isFaceUp = index == newValue
			}
		}
	}
	
	mutating func chose(card: Card) {
		print("chosen card \(card)")
		if let chosenIndex = cards.FirstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
			if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
				if cards[potentialMatchIndex].content == cards[chosenIndex].content {
					cards[chosenIndex].isMatched = true
					cards[potentialMatchIndex].isMatched = true
				}
				cards[chosenIndex].isFaceUp = true
			} else {
				indexOfTheOneAndOnlyFaceUpCard = chosenIndex
			}
		}
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
		var isFaceUp = false
		var isMatched = false
		var content: CardContent
		var id: Int
	}
}
