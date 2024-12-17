//
//  SecondScreen.swift
//  Christmas Matching Game
//
//  Created by Samuel Amante on 12/15/24.
//

import SwiftUI

struct SecondScreen: View { // VARIABLES BELOW FOR MY CHRISTMAS themed game
    @State private var items = ["🎄", "🎅🏻", "🎁", "☃️", "❄️", "🛷", "⛷️","🍪","🥛"] // christmas themed items for the game
    @State private var rearrangedItems: [String] = [] // array for items
    @State private var selectedItems: [Int] = [] // an array that figures out which items have been chosen or in this game which items have been flipped over
    @State private var matchedItems: [Int] = [] // this variable is an array that keeps track of every item that goes with each item
    @State private var gameWon: Bool = false // this variable determines whether the game was been won
    
    var body: some View {
        ZStack {
            Image("Snowman")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            CustomText(text: "Christmas Matching")
                .padding(.bottom, 600)
            VStack(spacing: 10) { // grid settings for the matching game which makes it 18 circles total or 6 x 3 by looping over 3 r + 6 c. It includes settings regarding the spacing between each item
                ForEach(0..<3, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<6, id: \.self) { col in
                            let index = row * 6 + col // this constant finds where on the grid the certain christmas emojis are
                            if index < rearrangedItems.count {
                                ZStack {
                                    Circle() // the properties below include the color of the circle (christmas colors) before and after flipping it, size of the circle
                                        .fill(selectedItems.contains(index) || matchedItems.contains(index) ? Color.red : Color.green)
                                        .frame(width: 50, height: 70)
                                        .clipShape(Rectangle())
                                    if selectedItems.contains(index) || matchedItems.contains(index) {
                                        Text(rearrangedItems[index])
                                            .font(.largeTitle)
                                            .transition(.scale)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.smooth) {
                                        cardTapped(index: index)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Button("Restart") {
                withAnimation(.smooth) {
                    restartMatch()
                }
            }
            // 
            .font(Font.custom("Marker Felt", size: 33))
            .font(.largeTitle).bold()
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(10)
            .padding(.top, 600)
        }
        // tells us that the game is finished with a title that states winner along with a little message. Below that there is a play again button to reset the game if you want to play again (remember to say that it rearranges the items during the video).
        
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
    func rearrangeItems() { // this is used to create a new array with 2 of each emoji when rearrange because of the items + items
        rearrangedItems = (items + items).shuffled()
    }
    func cardTapped(index: Int) { // it finds out whether or not you have selected two green circles and then clears it after
        if selectedItems.count == 2 {
            selectedItems.removeAll()
        }
        if !matchedItems.contains(index) { // says that if there are two items that are selected together it will see if they match by being added to the same array and if they match it will realize if it is a match through the checkforW f and goes farther by realizing if the game has been won
            selectedItems.append(index)
            if selectedItems.count == 2 {
                checkForWinner()
            }
        }
    }
    func checkForWinner() { // states that if all the items from the index's match they will be put into the matchedItems array and to see if the game is won it will check and find out if the amount of matched items equals the rearranged items and then it will make the game finish since you won
        let firstIndex = selectedItems[0]
        let secondIndex = selectedItems[1]
        if rearrangedItems[firstIndex] == rearrangedItems[secondIndex] {
            matchedItems += selectedItems
            if matchedItems.count == rearrangedItems.count {
                gameWon = true
            }
        }
    }
    func restartMatch() { // function for restart button that removes all the existing matches and locations in the grid because it uses .removeall for both matched items and selected items and then asks for the items to be shuffled.
        matchedItems.removeAll()
        selectedItems.removeAll()
        rearrangeItems()
    }
}

#Preview {
    SecondScreen()
}
