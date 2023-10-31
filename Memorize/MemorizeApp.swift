//
//  MemorizeApp.swift
//  Memorize
//
//  Created by ivan trajanovski  on 30.10.23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
