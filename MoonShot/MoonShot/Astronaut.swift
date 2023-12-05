//
//  Astronaut.swift
//  MoonShot
//
//  Created by Igor L on 25/11/2023.
//

import Foundation

struct Astronaut: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
}
