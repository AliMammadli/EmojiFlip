//
//  Cardify.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 11.12.24.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFacedUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            
            base.fill(.white)
                .strokeBorder(lineWidth: Constants.lineWidth)
                .overlay(content)
                .opacity(isFacedUp ? 1 : 0)
            base.opacity(isFacedUp ? 0 : 1)
        }
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
