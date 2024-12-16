//
//  SecondScreen.swift
//  Christmas Matching Game
//
//  Created by Samuel Amante on 12/15/24.
//

import SwiftUI

struct SecondScreen: View {
    @State private var items = ["🎄", "🎅🏻", "🎁", "☃️", "❄️", "🛷"] // cards for game
    @State private var rearrangedItems: [String] = []
    @State private var selectedItems: [Int] = []
    @State private var matchedItems: [Int] = []
    @State private var gameWon: Bool = false
    var body: some View {
        ZStack {
            Image("Christmas Tree Indoor") // added chirstmas tree background image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            Text("Placeholder") // title for the christmas game
                .font(.largeTitle).bold()
                .background(Color.white)
                .position(x: 379, y:170)
                .padding()
            GridStack(rows: 2, columns: 6) { row, col in
                let index = row * 6 + col
                if index < rearrangedItems.count {
                    return AnyView(
                        ItemView(symbol: self.rearrangedItems[index], isFlipped: self.selectedItems.contains(index) ||
                        self.matchedItems.contains(index))
                        .onTapGesture {
                            withAnimation(.smooth) {
                                self.cardTapped(index: index)
                            }
                        }
                    )
                } else {
                    return AnyView(EmptyView())
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).stroke(Color.red,lineWidth: 4))
            .padding()
            Button("Restart") {
                withAnimation(.smooth) {
                    self.restartMatch()
                }
            }
            .font(.largeTitle)
            .background()
            .background(Color.white)
            .foregroundStyle(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
            .position(x: 400, y: 600)
            }
        .onAppear(perform: rearrangeItems)
        .alert(isPresented: self.$gameWon) {
            Alert(title: Text("Winner"), message: Text("YOU BEAT THE GAME"), dismissButton: .default(Text("Play Again"), action: {
                withAnimation(.smooth) {
                    self.restartMatch()
                }
            }))
        }
        }
        func rearrangeItems() {
            rearrangedItems = (items + items).shuffled()
        }
        func cardTapped(index: Int) {
            if selectedItems.count == 2 {
                selectedItems.removeAll()
            }
            
            if !matchedItems.contains(index) {
                selectedItems.append(index)
                if selectedItems.count == 2 {
                    checkForWinner()
                }
            }
        }
        func checkForWinner() {
            let firstIndex = selectedItems[0]
            let secondIndex = selectedItems[1]
            if rearrangedItems[firstIndex] == rearrangedItems[secondIndex] {
                matchedItems += selectedItems
                if matchedItems.count == rearrangedItems.count {
                    gameWon = true
                }
            }
        }
        func restartMatch() {
            matchedItems.removeAll()
            selectedItems.removeAll()
            rearrangeItems()
        }
    }
    
    #Preview {
        SecondScreen()
    }
    struct ItemView: View {
        var symbol: String
        var isFlipped: Bool
        
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(isFlipped ? Color.red : Color.green)
                    .frame(width: 50, height: 70)
                    .clipShape(RoundedRectangle(cornerRadius: 10)).shadow(radius: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                if isFlipped {
                    Text(symbol)
                        .font(.largeTitle)
                        .transition(.scale)
                }
            }
        }
    }
    struct GridStack: View {
        var rows: Int
        var columns: Int
        let content: (Int, Int) -> AnyView
        
        var body: some View {
            VStack(spacing: 10) {
                ForEach(0 ..< rows, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<self.columns, id: \.self) { column in
                            content(row, column)
                        }
                    }
                }
            }
        }
    }
