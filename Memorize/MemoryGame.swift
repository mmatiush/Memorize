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
	private(set) var cards: Array<Card>
	
	private var indexOfTheOneAndOnlyFaceUpCard: Int? {
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
		cards.shuffle()
	}
	
	struct Card: Identifiable {
		var isFaceUp = false {
			didSet {
				if isFaceUp {
					startUsingBonusTime()
				} else {
					stopUsingBonusTime()
				}
			}
		}
		var isMatched = false {
			didSet {
				stopUsingBonusTime()
			}
		}
		var content: CardContent
		var id: Int
		
		

		// place this code block inside the Card struct
		// MARK: - Bonus Time
		// this could give matching bonus points
		// if the user matches the card
		// before a certain amount of time passes during which the card is face up
		// can be zero which means "no bonus available" for this card
		var bonusTimeLimit: TimeInterval = 6

		// how long this card has ever been face up
		private var faceUpTime: TimeInterval {
			if let lastFaceUpDate = self.lastFaceUpDate {
				return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
			} else {
				return pastFaceUpTime
			}
		}
		// the last time this card was turned face up (and is still face up)
		var lastFaceUpDate: Date?
		// the accumulated time this card has been face up in the past
		// (i.e. not including the current time it's been face up if it is currently so)
		var pastFaceUpTime: TimeInterval = 0

		// how much time left before the bonus opportunity runs out
		var bonusTimeRemaining: TimeInterval {
			max(0, bonusTimeLimit - faceUpTime)
		}
		// percentage of the bonus time remaining
		var bonusRemaining: Double {
			(bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
		}
		// whether the card was matched during the bonus time period
		var hasEarnedBonus: Bool {
			isMatched && bonusTimeRemaining > 0
		}
		// whether we are currently face up, unmatched and have not yet used up the bonus window
		var isConsumingBonusTime: Bool {
			isFaceUp && !isMatched && bonusTimeRemaining > 0
		}
		// called when the card transitions to face up state
		private mutating func startUsingBonusTime() {
			if isConsumingBonusTime, lastFaceUpDate == nil {
				lastFaceUpDate = Date()
			}
		}
		// called when the card goes back face down (or gets matched)
		private mutating func stopUsingBonusTime() {
			pastFaceUpTime = faceUpTime
			self.lastFaceUpDate = nil
		}

		
	}
	

	
	
	

	
}














