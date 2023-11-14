//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by ivan trajanovski  on 30.10.23.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State private var selectedThemeIndex = 0
    
    var themes: [Theme<String>] {
        viewModel.availableThemes()
    }
    
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
                
                Picker("Select Theme", selection: $selectedThemeIndex) {
                    ForEach(themes.indices, id: \.self) { index in
                        Text(themes[index].name).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectedThemeIndex) { _ in
                    viewModel.newGame(themeIndex: selectedThemeIndex)
                }
                
                HStack(spacing: 50) {
                    Button("Shuffle", systemImage: "shuffle") {
                        viewModel.shuffle()
                    }
                    
                    Button("New Game", systemImage: "restart") {
                        viewModel.newGame(themeIndex: selectedThemeIndex)
                    }
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

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
