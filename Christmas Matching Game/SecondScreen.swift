//
//  SecondScreen.swift
//  Christmas Matching Game
//
//  Created by Samuel Amante on 12/15/24.
//

import SwiftUI

struct SecondScreen: View {
    @State private var items = ["🎄", "🎅🏻", "🎁", "☃️", "❄️", "🛷"]
    @State private var rearrangedItems: [String] = []
    @State private var selectedItems: [Int] = []
    @State private var matchedItems: [Int] = []
    @State private var gameWon: Bool = false
    var body: some View {
        ZStack {
            Image("Christmas Tree Indoor")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        Text("Placeholder")
                .font(.largeTitle).bold()
                .background(Color.white)
                .position(x: 379, y:170)
                .padding()
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
