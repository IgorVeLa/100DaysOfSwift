//
//  ContentView.swift
//  DiceRoll
//
//  Created by Igor L on 15/04/2024.
//

import SwiftData 
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var rolls: [Roll]
    @State private var rolledNumber = 0
    
    @State private var rollArr = [Int]()
    @State private var rollTimeRemaining = 7
    @State private var timerRunning = false
    @State private var timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { fullView in
            VStack {
                HStack {
                    ForEach(rolls[rolls.endIndex - 6..<rolls.endIndex - 1]) { roll in
                        GeometryReader { proxy in
                            Text(String(roll.number))
                                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                                .opacity(fadeOpacity(xOffset: proxy.frame(in: .global).minX))
                        }
                    }
                }
                .frame(width: fullView.size.width * 0.28, height: fullView.size.height * 0.05, alignment: .center)
                
                Button {
                    // animation
                    if !timerRunning {
                        rollTimeRemaining = 10
                        startTimer()
                    } else {
                        stopTimer()
                    }
                    timerRunning.toggle()
                } label: {
                    Text(timerRunning ? String(rolledNumber) : String(rolls[rolls.count - 1].number))
                        .font(.system(size: 1000))
                        .minimumScaleFactor(0.01)
                        .frame(width: fullView.size.width * 0.35, height:fullView.size.width * 0.35)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .shadow(radius: 10)
                        .padding(.bottom, 50)
                        .contentTransition(.numericText(value: Double(rolledNumber)))
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
            }
            .frame(width: fullView.size.width, height: fullView.size.height)
        }
        .onAppear() {
            self.stopTimer()
        }
    }
    
    func fadeOpacity(xOffset: CGFloat) -> Double {
        return max(0, 1 - (500 - xOffset) / 450)
    }
    
    func stopTimer() {
        print("STOP TIMER")
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        print("START TIMER")
        self.timer = Timer.publish(every: 0.3, on: .main, in: .common).autoconnect()
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}
