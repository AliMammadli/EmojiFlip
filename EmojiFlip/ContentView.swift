//
//  ContentView.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 07.12.24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙🏻‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountControls
            .font(.largeTitle)
            .padding()
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
    }
    
    var cardCountControls: some View {
        HStack {
            cardRemoveBtn
            Spacer()
            cardAddBtn
        }
    }
    
    func cardCountController(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemoveBtn: some View {
        cardCountController(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAddBtn: some View {
        cardCountController(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
}

struct CardView: View {
    let content: String
    @State var isOpened = false
    
    var body: some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2)
                    .foregroundColor(.pink)
                    .onTapGesture {
                        isOpened.toggle()
                    }
                Text(content).font(.largeTitle)
            }
            .opacity(isOpened ? 1 : 0)
            RoundedRectangle(cornerRadius: 12)
                .fill(.pink)
                .opacity(isOpened ? 0 : 1)
                .onTapGesture {
                    isOpened.toggle()
                }
        }
    }
}

#Preview {
    ContentView()
}
