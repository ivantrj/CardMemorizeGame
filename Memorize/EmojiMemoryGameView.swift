//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by ivan trajanovski  on 30.10.23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
//    @State var emojis: [String]
    @State var selectedTheme: Theme?
    
    enum Theme {
        case halloween, vehicles, animals
    }
    
    static let halloweenEmojis: [String] = ["👻", "🎃", "🕷️", "😈", "👻", "🎃", "🕷️", "😈", "👹", "🦇"]
    static let vehicleEmojis: [String] = ["🚗", "🚕", "🚲", "🛴", "🚆", "✈️", "🚢", "🚁", "🏍️", "🚓", "🚜", "🛵", "🚒", "🚑", "🚂", "🛺"]
    static let animalEmojis: [String] = ["🐶", "🐱", "🐭", "🐰", "🐻", "🐨", "🐯", "🦁", "🦊", "🐸", "🦉"]

    
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
                        ForEach(viewModel.cards) { card in
                            CardView(card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .padding(4)
                                .onTapGesture {
                                    viewModel.choose(card)
                                }
                        }
                    }
                    .animation(.default, value: viewModel.cards)
                }
                .foregroundColor(.orange)
                .padding()
                .navigationTitle("Memorize!")
                
                Button("Shuffle", systemImage: "shuffle") {
                    viewModel.shuffle()
                }
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

struct ThemeButton: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            VStack {
                Image(systemName: icon)
                    .font(.title)
                Text(title)
                    .font(.headline)
            }
        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
