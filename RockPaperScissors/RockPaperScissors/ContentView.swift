//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Igor L on 04/11/2023.
//


import SwiftUI

struct ContentView: View {
    private var moves = ["rock", "paper", "scissors"]
    private var winningMoves = ["paper", "scissors", "rock"]
    
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var showScore = false
    @State private var showReset = false
    @State private var scoreTitle = ""
    @State private var scoreMsg = ""
    @State private var score = 0
    @State private var turns = 0
    @State private var lives = 10
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                Gradient.Stop(color: .white, location: 0.2),
                Gradient.Stop(color: .gray, location: 0.9),
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            VStack {
                Text("Score: \(score)/\(turns)")
                    .font(.system(.title, design: .monospaced))
                Text("Best out of 10")
                    .opacity(0.4)
                    .padding(.bottom)
                Text("Their move: \(moves[appMove])")
                    .font(.system(.title3))
                Group {
                    Text("Should you win: ")
                    + Text(shouldWin ? "yes" : "no")
                        .foregroundColor(shouldWin ? .green : .red)
                        .fontWeight(.bold)
                }
                .font(.title3)
                .padding(.bottom)
    
                Text("Your move:")
                    .font(.headline)
                HStack {
                    Button {
                        moveTapped(move: "rock")
                    } label: {
                        Text("🪨")
                            .font(.title)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        moveTapped(move: "paper")
                    } label: {
                        Text("📄")
                            .font(.title)
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        moveTapped(move: "scissors")
                    } label: {
                        Text("✂️")
                            .font(.title)
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        
        
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: nextMove)
        } message: {
            Text("\(scoreMsg)")
        }
        
        .alert("GAME OVER", isPresented: $showReset) {
            Button("Reset", action: resetGame)
        } message: {
            Text("You got a final score of \(score)/\(turns)")
        }
    }

    
    func moveTapped(move: String) {
        if moves[appMove] == move {
            scoreTitle = "It's a tie!"
            scoreMsg = ""
            showScore = true
            turns = turns + 1
            lives = lives - 1
        } else if shouldWin == true {
            if move == winningMoves[appMove] {
                winCondition()
            } else {
                loseCondition()
            }
        } else {
            if move == winningMoves[appMove] {
                loseCondition()
            } else {
                winCondition()
            }
        }
        
        if lives == 0 {
            showScore = false
            showReset = true
        }
    }
    
    func winCondition() {
        scoreTitle = "Yay! You won that turn!"
        scoreMsg = ""
        showScore = true
        score = score + 1
        turns = turns + 1
        lives = lives - 1
    }
    
    func loseCondition() {
        scoreTitle = "You lost"
        scoreMsg = ""
        showScore = true
        turns = turns + 1
        lives = lives - 1
    }
    
    func nextMove() {
        appMove = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func resetGame() {
        lives = 10
        turns = 0
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
