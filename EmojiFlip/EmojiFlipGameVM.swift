//
//  EmojiFlipGameVM.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 09.12.24.
//

import SwiftUI

class EmojiFlipGameVM: ObservableObject {
    typealias Card = EmojiFlipGameM<String>.Card
    
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙🏻‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    private static func createEmojiFlipGame() -> EmojiFlipGameM<String> {
        return EmojiFlipGameM(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⚠️"
            }
        }
    }
    
    @Published private var model = createEmojiFlipGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    var color: Color {
        .orange
    }
    
    var score: Int {
        model.score
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
