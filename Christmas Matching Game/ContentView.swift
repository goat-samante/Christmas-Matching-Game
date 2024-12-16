//
//  ContentView.swift
//  Christmas Matching Game
//
//  Created by Samuel Amante on 12/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Image("Snowman")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                CustomText(text: "Christmas Matching Game")
                    .foregroundColor(.red)
                    .font(.largeTitle).bold()
                    .background(Color.mint)
                    .position(x:218,y:350)
                    .cornerRadius(10)
                
                VStack {
                    NavigationLink(destination: SecondScreen()) {
                        
                        CustomText(text: "Enter Game")
                            .padding()
                            .font(.largeTitle).bold()
                            .background(Color.black)
                            .cornerRadius(10)
                            .position(x: 218, y: 750)
                    }
                }
            }
        }
    }
}
struct CustomText: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Marker Felt", size: 33))
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(10)
    }
}
struct CustomTextButton: View {
    let text: String
    var body: some View {
        Text(text).font(Font.custom("Marker Felt", size: 36))
            .foregroundColor(.black)
    }
}
#Preview {
    ContentView()
}
