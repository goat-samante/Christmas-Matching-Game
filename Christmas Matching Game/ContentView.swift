//
//  ContentView.swift
//  Christmas Matching Game
//
//  Created by Samuel Amante on 12/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Christmas Tree Indoor") // christmas tree image
                    .resizable() // properties for the image which allow it to shrink and fill the full screen. The .edgesIgnoringSafeArea allow for a clean look
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    CustomText(text: "Christmas Matching Game") // the title for the game
                            .padding(.bottom, 20)
                    
                    NavigationLink(destination: SecondScreen()) { // teleports you to the screen with the game and contains the UI properties for the text for the button
                        CustomText(text: "Enter Game")
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct CustomText: View { // custom text settings and properties for all the text and the text on the other screen aswell.
    let text: String
    var body: some View {
        Text(text)
            .font(Font.custom("Marker Felt", size: 33))
            .font(.largeTitle).bold()
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}


