//
//  ContentView.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 07.12.24.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "🎃", "🕷️", "😈", "💀"]
    
    var body: some View {
        VStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isOpened = false
    
    var body: some View {
        ZStack {
            if isOpened {
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 5)
                    .foregroundColor(.pink)
                    .onTapGesture {
                        isOpened.toggle()
                    }
                Text(content).font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.pink)
                    .onTapGesture {
                        isOpened.toggle()
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
