//
//  DiceView.swift
//  DiceRoll
//
//  Created by Igor L on 26/04/2024.
//

import Foundation
import SwiftUI

struct DiceModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 1000))
            .minimumScaleFactor(0.01)
            //.frame(width: proxy.size.width * 0.35, height: proxy.size.height * 0.2, alignment: .center)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .shadow(radius: 10)
            .padding(.bottom, 50)
            //.frame(width: proxy.size.width * 1, height: proxy.size.height * 1, alignment: .center)
            //.contentTransition(.numericText(value: Double(rolledNumber)))
    }
}

extension View {
    func diceModifier() -> some View {
        modifier(DiceModifier())
    }
}

struct DiceView: View {
    @Environment(\.modelContext) var modelContext
    var rolls: [Roll]
    
    @State private var rollArr = [Int]()
    @State private var rolledNumber = 0
    @State private var rollTimeRemaining = 10
    @State private var timerRunning = false
    @State private var timer = Timer.publish(every: 0.075, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { proxy in
            Button {
                print(rolls)
                // animation
                if !timerRunning {
                    rollTimeRemaining = 10
                    startTimer()
                } else {
                    stopTimer()
                }
                timerRunning.toggle()
            } label: {
                if rolls.isEmpty {
                    Text(timerRunning ? "Rolling..." : "Roll")
                        .frame(width: proxy.size.width * 0.35, height: proxy.size.height * 0.2, alignment: .center)
                        .diceModifier()
                        .frame(width: proxy.size.width * 1, height: proxy.size.height * 1, alignment: .center)
                } else {
                    Text(timerRunning ? String(rolledNumber) : String(rolls[rolls.count - 1].number))
                        .frame(width: proxy.size.width * 0.35, height: proxy.size.height * 0.2, alignment: .center)
                        .diceModifier()
                        .frame(width: proxy.size.width * 1, height: proxy.size.height * 1, alignment: .center)
                }
            }
            .buttonStyle(.plain)
            .onReceive(timer) { time in
                if rollTimeRemaining > 0 {
                    rollArr.append(Int.random(in: 1...6))
                    withAnimation {
                        rolledNumber = rollArr.last ?? 3
                    }
                    
                    rollTimeRemaining -= 1
                } else {
                    // add to swift data
                    let newRoll = Roll()
                    rolledNumber = rollArr.last ?? 3
                    newRoll.number = rolledNumber
                    modelContext.insert(newRoll)
                    // reset
                    rollArr = [Int]()
                    self.stopTimer()
                    timerRunning = false
                }
            }
            .frame(width: proxy.size.width, height: proxy.size.height * 1, alignment: .center)
        }
        .onAppear() {
            self.stopTimer()
        }
    }
        
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.075, on: .main, in: .common).autoconnect()
    }
}

#Preview {
    DiceView(rolls: sampleRolls)
        .modelContainer(previewContainer)
}
