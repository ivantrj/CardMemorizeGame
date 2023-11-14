//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by ivan trajanovski  on 30.10.23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let themes: [Theme<String>] = [
        Theme(name: "Halloween", emojis: ["👻", "🎃", "🕷️", "😈", "👻", "🎃", "🧙", "😈"], numberOfPairs: 6, cardColor: .orange),
        Theme(name: "Animals", emojis: ["🐶", "🐱", "🐰", "🦊", "🐼", "🐯", "🦁", "🐻"], numberOfPairs: 6, cardColor: .green),
        Theme(name: "Sports", emojis: ["⚽️", "🏀", "🎾", "🏈", "⚾️", "🏐", "🏉", "🏓"], numberOfPairs: 6, cardColor: .blue),
        Theme(name: "Fruits", emojis: ["🍎", "🍌", "🍇", "🍓", "🍍", "🍑", "🥭", "🍉"], numberOfPairs: 6, cardColor: .red),
        Theme(name: "Weather", emojis: ["☀️", "🌦️", "❄️", "⚡", "🌪️", "🌈", "☔", "🌊"], numberOfPairs: 6, cardColor: .gray),
        Theme(name: "Cars", emojis: ["🚗", "🚕", "🚙", "🚌", "🚓", "🏎️", "🚑", "🚒"], numberOfPairs: 6, cardColor: .yellow)
    ]
    
    private static func createMemoryGame(withTheme theme: Theme<String>) -> MemoryGame<String> {
        return MemoryGame(theme: theme, numberOfPairsOfCards: 6) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "😅"
            }
        }
    }
    
    @Published private var model = createMemoryGame(withTheme: themes[0])
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func availableThemes() -> [Theme<String>] {
        EmojiMemoryGame.themes
    }
    
    // MARK:  - Intents
    
    func newGame(themeIndex: Int) {
        let selectedTheme = EmojiMemoryGame.themes[themeIndex]
        model = EmojiMemoryGame.createMemoryGame(withTheme: selectedTheme)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
