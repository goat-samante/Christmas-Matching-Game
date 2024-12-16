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
                Image("Christmas Tree Indoor")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    CustomText(text: "Christmas Matching Game")
                        .foregroundColor(.red)
                        .font(.largeTitle).bold()
                        .background(Color.mint)
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                    
                    NavigationLink(destination: SecondScreen()) {
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

struct CustomText: View {
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


