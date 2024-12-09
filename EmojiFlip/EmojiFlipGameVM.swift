//
//  EmojiFlipGameVM.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 09.12.24.
//

import SwiftUI

class EmojiFlipGameVM: ObservableObject {
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙🏻‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    private static func createEmojiFlipGame() -> EmojiFlipGameM<String> {
        return EmojiFlipGameM(numberOfPairsOfCards: 12) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⚠️"
            }
        }
    }
    
    @Published private var model = createEmojiFlipGame()
    
    var cards: Array<EmojiFlipGameM<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: EmojiFlipGameM<String>.Card) {
        model.choose(card)
    }
}
