//
//  ContentView.swift
//  Memorize
//
//  Created by ivan ruwido  on 30.10.23.
//

import SwiftUI

struct ContentView: View {
    @State var emojis: [String]
    @State var selectedTheme: Theme?
    
    enum Theme {
        case halloween, vehicles, animals
    }
    
    let halloweenEmojis: [String] = ["👻", "🎃", "🕷️", "😈", "👻", "🎃", "🕷️", "😈", "👹", "🦇"]
    let vehicleEmojis: [String] = ["🚗", "🚕", "🚲", "🛴", "🚆", "✈️", "🚢", "🚁", "🏍️", "🚓", "🚜", "🛵"]
    let animalEmojis: [String] = ["🐶", "🐱", "🐭", "🐰", "🐻", "🐨", "🐯", "🦁", "🦊", "🐸"]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
                    ForEach(emojis.indices, id: \.self) { index in
                        CardView(content: emojis[index])
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            .padding()
            .navigationTitle("Memorize!")
        }
        
        HStack(spacing: 25) {
            ThemeButton(icon: "car", title: "Vehicles") {
                self.selectedTheme = .vehicles
                self.emojis = vehicleEmojis.shuffled()
            }
            ThemeButton(icon: "compass.drawing", title: "Halloween") {
                self.selectedTheme = .halloween
                self.emojis = halloweenEmojis.shuffled()
            }
            ThemeButton(icon: "cat", title: "Animals") {
                self.selectedTheme = .animals
                self.emojis = animalEmojis.shuffled()
            }
        }
    }
}

struct CardView: View {
    @State var isFaceUp = false
    let content: String
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
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
                    .font(.headline)
                Text(title)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    ContentView(emojis: ["👻", "🎃", "🕷️", "😈", "👻", "🎃", "🧙", "😈"])
}
