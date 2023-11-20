//
//  ContentView.swift
//  Edutainment
//
//  Created by Igor L on 19/11/2023.
//

/*
 1. The player needs to select which multiplication tables they want to practice. This could be pressing buttons, or it could be an “Up to…” stepper, going from 2 to 12.
 2. The player should be able to select how many questions they want to be asked: 5, 10, or 20.
 3. You should randomly generate as many questions as they asked for, within the difficulty range they asked for.
 
 1. Start with an App template, then add some state to determine whether the game is active or whether you’re asking for settings.
 2. Generate a range of questions based on the user’s settings.
 3. Show the player how many questions they got correct at the end of the game, then offer to let them play again.
 
 Checklist:
 - Game state (Setting / Game)
 - Select multiplication tables (2 to 12)
 - Select how many questions (5, 10, 20)
 - Randomly generate questions
    - Based on difficulty
 */

import SwiftUI

struct questions {
    let questions = [
        "Select what mulitplication tables you want to practice",
        "How many question do you want to answer?",
        "What difficulty"
    ]
}

struct ContentView: View {
    var body: some View {
        Text("lol")
    }
}


struct GameView: View {
    @State private var gameState = false
    @State private var multiTables = [
        2: false,
        3: false,
        4: false,
        5: false,
        6: false,
        7: false,
        8: false,
        9: false,
        10: false,
        11: false,
        12: false,
    ]
    @State private var numOfQuestions = 10
    @State private var difficulty = "medium"
    
    var body: some View {
       NavigationStack {
           Form {
               Section {
                   HStack {
                       ForEach(2..<13) { number in
                           Button {
                               multiTables[number]?.toggle()
                           } label: {
                               Text(multiTables[number]! ? "\(Image(systemName: "\(number).square"))" : "\(number)")
                           }
                           .buttonStyle(.borderless)
                       }
                   }
               } header: {
                   Text("Select what mulitplication tables you want to practice")
               }
               
               Section {
                   Picker("How many question do you want to answer?", selection: $numOfQuestions) {
                       Text("5").tag(5)
                       Text("10").tag(10)
                       Text("20").tag(20)
                   }
                   .pickerStyle(.segmented)
               } header: {
                   Text("How many question do you want to answer?")
               }
               
               Section {
                   Picker("What difficulty", selection: $difficulty) {
                       Text("EASY").tag("easy")
                       Text("MEDIUM").tag("medium")
                       Text("HARD").tag("hard")
                   }
                   .pickerStyle(.segmented)
               } header: {
                   Text("What difficulty")
               }
           }
           .navigationTitle("Settings")
       }
   }
}


#Preview {
    ContentView()
}
