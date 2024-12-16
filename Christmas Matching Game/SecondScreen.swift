//
//  SecondScreen.swift
//  Christmas Matching Game
//
//  Created by Samuel Amante on 12/15/24.
//

import SwiftUI

struct SecondScreen: View {
    @State private var items = ["🎄", "🎅🏻", "🎁", "☃️", "❄️", "🛷", "⛷️","🍪","🥛"] // christmas themed items for the game
    @State private var rearrangedItems: [String] = []
    @State private var selectedItems: [Int] = []
    @State private var matchedItems: [Int] = []
    @State private var gameWon: Bool = false
    
    var body: some View {
        ZStack {
            Image("Snowman") // snowman background image
                .resizable() // properties for the image
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            CustomText(text: "Christmas Matching") // Title for the game, the text uses properties from the content view to make it uniform and look nice
                .padding(.bottom, 600)
            VStack(spacing: 10) { // grid settings for the matching game which makes it 18 squares total or 6 x 3. It includes settings regarding the spacing between each item, color of the circle before and after flipping it,
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<6, id: \.self) { col in
                            let index = row * 6 + col
                            if index < rearrangedItems.count {
                                ZStack {
                                    Circle()
                                        .fill(selectedItems.contains(index) || matchedItems.contains(index) ? Color.red : Color.green)
                                        .frame(width: 50, height: 70)
                                        .clipShape(Rectangle())
                                    if selectedItems.contains(index) || matchedItems.contains(index) {
                                        Text(rearrangedItems[index])
                                            .font(.largeTitle)
                                            .transition(.scale)
                                    }
                                }
                                .onTapGesture { // when tapping the circle it changes to the other side, also the animation makes it look cleaner.
                                    withAnimation(.smooth) {
                                        cardTapped(index: index)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Button("Restart") { // restart button which makes the card reshuffle
                withAnimation(.smooth) {
                    restartMatch()
                }
            }
            //  Font, color, positioning, and background for the restart button
            .font(Font.custom("Marker Felt", size: 33))
            .font(.largeTitle).bold()
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(10)
            .padding(.top, 600)
        }
        // tells us that the game is finished with a title that states winner along with a little message. Below that there is a play again button to reset the game if you want to play again.
        .onAppear(perform: rearrangeItems)
        .alert(isPresented: self.$gameWon) {
            Alert(
                title: Text("Winner"),
                message: Text("YOU BEAT THE GAME"),
                dismissButton: .default(Text("Play Again"), action: {
                    withAnimation(.smooth) {
                        restartMatch()
                    }
                })
            )
        }
    }
    func rearrangeItems() {
        rearrangedItems = (items + items).shuffled()
    }
    func cardTapped(index: Int) {
        if selectedItems.count == 2 {
            selectedItems.removeAll()
        }
        if !matchedItems.contains(index) { // says that if there are two matches it will see if they match and then
            selectedItems.append(index)
            if selectedItems.count == 2 {
                checkForWinner()
            }
        }
    }
    func checkForWinner() { // states that if all the items are found / matched the game wll end
        let firstIndex = selectedItems[0]
        let secondIndex = selectedItems[1]
        if rearrangedItems[firstIndex] == rearrangedItems[secondIndex] {
            matchedItems += selectedItems
            if matchedItems.count == rearrangedItems.count {
                gameWon = true
            }
        }
    }
    func restartMatch() { // function for restart button that removes all the existing matches and locations in the grid. It also reshuffles the items aswell.
        matchedItems.removeAll()
        selectedItems.removeAll()
        rearrangeItems()
    }
}

#Preview {
    SecondScreen()
}
