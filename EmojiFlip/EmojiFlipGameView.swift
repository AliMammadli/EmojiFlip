//
//  EmojiFlipGameView.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 07.12.24.
//

import SwiftUI

struct EmojiFlipGameView: View {
    @ObservedObject var viewModel: EmojiFlipGameVM
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
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
                    .foregroundColor(.pink)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFacedUp ? 1 : 0)
            RoundedRectangle(cornerRadius: 12)
                .fill(.pink)
                .opacity(card.isFacedUp ? 0 : 1)
        }
    }
}

#Preview {
    EmojiFlipGameView(viewModel: EmojiFlipGameVM())
}
