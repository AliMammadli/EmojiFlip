//
//  ContentView.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 07.12.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding()
    }
}

struct CardView: View {
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
                Text("👻").font(.largeTitle)
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
