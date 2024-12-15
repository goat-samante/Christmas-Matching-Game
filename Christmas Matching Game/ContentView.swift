//
//  ContentView.swift
//  Christmas Matching Game
//
//  Created by Samuel Amante on 12/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Image("Snowman")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
