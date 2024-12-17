//
//  EmojiFlipGame.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 09.12.24.
//

import Foundation

struct EmojiFlipGameM<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
    }
    
    var indexOfOneAndOnlyFacedUpCard: Int? {
        get { cards.indices.filter{ index in cards[index].isFacedUp }.only }
        set { cards.indices.forEach { cards[$0].isFacedUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFacedUp && !cards[chosenIndex].isMatched {
                if let potentialMatch = indexOfOneAndOnlyFacedUpCard {
                    if cards[chosenIndex].content == cards[potentialMatch].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatch].isMatched = true
                        score += 2 + cards[chosenIndex].bonus + cards[potentialMatch].bonus
                    } else {
                        if cards[chosenIndex].hasBeenSeen || cards[potentialMatch].hasBeenSeen {
                            score -= 1
                        }
                    }
                } else {
                    indexOfOneAndOnlyFacedUpCard = chosenIndex
                }
            }
            cards[chosenIndex].isFacedUp = true
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFacedUp = false {
            didSet {
                if isFacedUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                if oldValue && !isFacedUp {
                    hasBeenSeen = true
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var hasBeenSeen = false
        let content: CardContent
        
        // MARK: - Bonus Time
        
        // call this when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isFacedUp && !isMatched && bonusPercentRemaining > 0, lastFacedUpDate == nil {
                lastFacedUpDate = Date()
            }
        }
        
        // call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFacedUpTime = faceUpTime
            lastFacedUpDate = nil
        }
        
        // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        // this gets smaller and smaller the longer the card remains face up without being matched
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        // percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        // how long this card has ever been face up and unmatched during its lifetime
        // basically, pastFacedUpTime + time since lastFacedUpDate
        var faceUpTime: TimeInterval {
            if let lastFacedUpDate {
                return pastFacedUpTime + Date().timeIntervalSince(lastFacedUpDate)
            } else {
                return pastFacedUpTime
            }
        }
        
        // can be zero which would mean "no bonus available" for matching this card quickly
        var bonusTimeLimit: TimeInterval = 6
        
        // the last time this card was turned face up
        var lastFacedUpDate: Date?
        
        // the accumulated time this card was face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFacedUpTime: TimeInterval = 0
        
        var id: String
        
        var debugDescription: String {
            "\(id): \(content) \(isFacedUp ? "up" : "down") \(isMatched ? " matched" : "")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
