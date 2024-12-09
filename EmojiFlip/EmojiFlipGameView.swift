//
//  EmojiFlipGameView.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 07.12.24.
//

import SwiftUI

struct EmojiFlipGameView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙🏻‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            .font(.largeTitle)
            .padding()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFacedUp = false
    
    var body: some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
                    .strokeBorder(lineWidth: 2)
                    .foregroundColor(.pink)
                    .onTapGesture {
                        isFacedUp.toggle()
                    }
                Text(content).font(.largeTitle)
            }
            .opacity(isFacedUp ? 1 : 0)
            RoundedRectangle(cornerRadius: 12)
                .fill(.pink)
                .opacity(isFacedUp ? 0 : 1)
                .onTapGesture {
                    isFacedUp.toggle()
                }
        }
    }
}

#Preview {
    EmojiFlipGameView()
}
