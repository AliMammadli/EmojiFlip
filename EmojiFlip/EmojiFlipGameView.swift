//
//  EmojiFlipGameView.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 07.12.24.
//

import SwiftUI

struct EmojiFlipGameView: View {
    @ObservedObject var viewModel: EmojiFlipGameVM
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
            
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
}

struct CardView: View {
    let card: EmojiFlipGameM<String>.Card
    
    init(_ card: EmojiFlipGameM<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFacedUp ? 1 : 0)
            RoundedRectangle(cornerRadius: 12)
                .opacity(card.isFacedUp ? 0 : 1)
        }
        .foregroundColor(.pink)
        .opacity(card.isMatched ? 0 : 1)
    }
}

#Preview {
    EmojiFlipGameView(viewModel: EmojiFlipGameVM())
}
