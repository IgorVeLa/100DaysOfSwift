//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Igor L on 28/09/2023.
//

import SwiftUI

// Project 3 challenge 2
struct flagMod: ViewModifier {
    func body(content: Content) -> some View {
            content
                //.renderingMode(.original)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .shadow(radius: 5)
        }
}

// Project 3 challenge 2
extension View {
    func flagStyle() -> some View {
        modifier(flagMod())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    @State private var showingScore = false
    @State private var showingReset = false
    @State private var scoreTitle = ""
    @State private var scoreMsg = ""
    @State private var turns = 8
    @State private var score = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.25, green: 0.41, blue: 1), location: 0.3),
                .init(color: Color(red: 0.91, green: 0.92, blue: 0.97), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 600)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("GUESS THE FLAG")
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.bold))
                Spacer()
                Spacer()
                Text("Score: \(score)/8")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .padding([.bottom, .trailing], 20)
                Spacer()
                
                VStack {
                    Text("Tap the flag of:")
                        .foregroundColor(Color(red: 0.83, green: 0.86, blue: 0.95))
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(Color(red: 0.83, green: 0.86, blue: 0.95))
                        .font(.largeTitle.weight(.semibold))
                        .shadow(radius: 10)
                    Spacer()
                }
                
                VStack(spacing: 65) {
                    ForEach(0..<3) { number in
                        Button {
                           flagTapped(number)
                        } label: {
                            Image(countries[number])
                            // Project 3 challenge 2
                                .flagStyle()
                        }
                    }
                }
            }
            .padding()
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("\(scoreMsg)")
            }
            
            .alert("GAME OVER", isPresented: $showingReset) {
                Button("RESET", action: reset)
            } message: {
                Text("Your final score was \(score)/8")
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMsg = "Congrats that was correct answer!"
            score += 1
            turns -= 1
        } else {
            scoreTitle = "Wrong"
            scoreMsg = "Close! That was the flag of \(countries[number])"
            turns -= 1
        }
        
        if turns == 0 {
            showingReset = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        turns = 8
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
