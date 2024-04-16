//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Igor L on 15/04/2024.
//

import SwiftUI

@main
struct DiceRollApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Roll.self)
    }
}
