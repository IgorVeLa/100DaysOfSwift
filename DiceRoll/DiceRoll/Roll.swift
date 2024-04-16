//
//  Roll.swift
//  DiceRoll
//
//  Created by Igor L on 15/04/2024.
//

import SwiftData
import SwiftUI
import Foundation

@Model
class Roll {
    var number = 1
    var numberOfDie = 1
    var total = 1
    
    init(number: Int = 1) {
        self.number = number
    }
}
