//
//  RollHistoryView.swift
//  DiceRoll
//
//  Created by Igor L on 26/04/2024.
//

import Foundation
import SwiftUI

struct RollHistoryView: View {
    var rolls: [Roll]
    
    var body: some View {
        if rolls.isEmpty {
            EmptyView()
        } else {
            if rolls.count <= 5 {
                HStack {
                    ForEach(rolls) { roll in
                        GeometryReader { proxy in
                            Text(String(roll.number))
                                .font(.title)
                                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                                .opacity(fadeOpacity(xOffset: proxy.frame(in: .global).minX))
                        }
                    }
                }
            } else {
                HStack {
                    ForEach(rolls[rolls.endIndex - 6..<rolls.endIndex - 1]) { roll in
                        GeometryReader { proxy in
                            Text(String(roll.number))
                                .font(.title)
                                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                                .opacity(fadeOpacity(xOffset: proxy.frame(in: .global).minX))
                        }
                    }
                }
            }
        }
    }
    
    func fadeOpacity(xOffset: CGFloat) -> Double {
        return max(0, 1 - (500 - xOffset) / 450)
    }
}

#Preview {
    RollHistoryView(rolls: sampleRolls)
}
