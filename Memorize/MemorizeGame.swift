//
//  MemorizeGame.swift
//  Memorize
//
//  Created by ivan ruwido  on 30.10.23.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
