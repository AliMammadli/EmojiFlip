//
//  EmojiFlipApp.swift
//  EmojiFlip
//
//  Created by Ali Mammadli on 07.12.24.
//

import SwiftUI

@main
struct EmojiFlipApp: App {
    @StateObject var game = EmojiFlipGameVM()
    
    var body: some Scene {
        WindowGroup {
            EmojiFlipGameView(viewModel: game)
        }
    }
}
