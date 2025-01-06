//
//  ContentView.swift
//  ForWidget
//
//  Created by 황석현 on 1/6/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var countNum = 0
    var sharedFunctions = SharedFunctions()
    
    
    var body: some View {
        VStack {
            Text("\(countNum)")
                .font(.largeTitle)
            
            Button("Increment") {
                countNum = sharedFunctions.saveNumber(number: countNum)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
