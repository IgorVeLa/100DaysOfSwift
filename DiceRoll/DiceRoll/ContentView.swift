//
//  ContentView.swift
//  DiceRoll
//
//  Created by Igor L on 15/04/2024.
//

import SwiftData 
import SwiftUI

struct ContentView: View {
    @Query private var rolls: [Roll]
    
    var body: some View {
        GeometryReader { fullView in
            VStack {
                DiceView(rolls: rolls)
                    .frame(width: fullView.size.width, height: fullView.size.height * 0.9, alignment: .center)
                    
                RollHistoryView(rolls: rolls)
                    .frame(width: fullView.size.width * 0.28, height: fullView.size.height * 0.05, alignment: .center)
                   
            }
            .frame(width: fullView.size.width, height: fullView.size.height)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
