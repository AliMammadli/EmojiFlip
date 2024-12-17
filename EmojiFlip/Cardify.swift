//
//  Cardify.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 11.12.24.
//

import SwiftUI

struct Cardify: ViewModifier, Animatable {
    init(isFacedUp: Bool) {
        rotation = isFacedUp ? 0 : 180
    }
    
    var isFacedUp: Bool { rotation < 90 }
    
    var rotation: Double
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            
            base.fill(.white)
                .strokeBorder(lineWidth: Constants.lineWidth)
                .overlay(content)
                .opacity(isFacedUp ? 1 : 0)
            base.opacity(isFacedUp ? 0 : 1)
        }
        .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}

extension View {
    func cardify(isFacedUp: Bool) -> some View {
        modifier(Cardify(isFacedUp: isFacedUp))
    }
}
