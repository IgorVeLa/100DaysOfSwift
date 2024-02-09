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
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    @State private var userAnswer = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    @State private var showingScore = false
    @State private var showingReset = false
    @State private var scoreTitle = ""
    @State private var scoreMsg = ""
    @State private var turns = 8
    @State private var score = 0
    
    @State private var degreeAmount = [0.0, 0.0, 0.0]
    @State private var opacityAmount = [1.0, 1.0, 1.0]
    @State private var scaleAmount = [1.0, 1.0, 1.0]
    
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
                            userAnswer = number
                        } label: {
                            Image(countries[number])
                            // Project 3 challenge 2
                                .flagStyle()
                        }
                        // Project 6: Challenge 1
                        .rotation3DEffect(.degrees(degreeAmount[number]), axis: (x:0,y:1,z:0))
                        // Project 6: Challenge 2
                        .opacity(opacityAmount[number])
                        // Project 6: Challenge 3
                        .scaleEffect(scaleAmount[number])
                        // Project 15: Part 2 
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
                    }
                }
            }
            .padding()
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)            } message: {
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
        
        // Project 6: Challenge 1
        withAnimation {
            degreeAmount[number] += 360
        }
        
        for notSelected in 0..<3 where notSelected != number {
            withAnimation {
                // Project 6: Challenge 2
                opacityAmount[notSelected] = 0.25
                // Project 6: Challenge 3
                scaleAmount[notSelected] = 0.85
            }
        }
        
        if turns == 0 {
            showingReset = true
            
            degreeAmount = [0.0, 0.0, 0.0]
            opacityAmount = [1.0, 1.0, 1.0]
            scaleAmount = [1.0, 1.0, 1.0]
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        degreeAmount = [0.0, 0.0, 0.0]
        opacityAmount = [1.0, 1.0, 1.0]
        scaleAmount = [1.0, 1.0, 1.0]
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
