//
//  ContentView.swift
//  MoonShot
//
//  Created by Igor L on 23/11/2023.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showGrid = true
    
    var body: some View {
        NavigationStack {
            // Challenge 3
            Group {
                if showGrid {
                    GridView(astronauts: astronauts, missions: missions)
                } else {
                    ListView(astronauts: astronauts, missions: missions)
                }
                
            }
            .navigationTitle("Moonshot")
            // Challenge 3
            .toolbar {
                Button {
                    showGrid.toggle()
                } label: {
                    Text(showGrid ? "List layout" : "Grid layout")
                }
            }
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}

