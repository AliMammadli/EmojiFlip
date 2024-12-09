//
//  EmojiFlipGame.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 09.12.24.
//

import Foundation

struct EmojiFlipGame<CardContent> {
    private(set) var cards: [Card]
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFacedUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
