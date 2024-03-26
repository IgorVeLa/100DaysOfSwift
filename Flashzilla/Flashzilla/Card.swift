//
//  Card.swift
//  Flashzilla
//
//  Created by Igor L on 21/03/2024.
//

import Foundation

struct Card: Codable, Hashable {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who's the biggest gaslighter?", answer: "Gabe")
}
