//
//  CardView.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 11.12.24.
//

import SwiftUI

struct CardView: View {
    typealias Card = EmojiFlipGameM<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .modifier(Cardify(isFacedUp: card.isFacedUp))
            .opacity(card.isMatched ? 0 : 1)
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
}

#Preview {
    VStack {
        HStack {
            CardView(CardView.Card(isFacedUp: true, content: "X", id: "ID1"))
            CardView(CardView.Card(isFacedUp: false, content: "X", id: "ID1"))
        }
        HStack {
            CardView(CardView.Card(isFacedUp: true, content: "X", id: "ID1"))
            CardView(CardView.Card(isMatched: true, content: "X", id: "ID1"))
        }
    }
    .padding()
    .foregroundColor(.green)
}
